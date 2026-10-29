#!/usr/bin/env bash
# 简历构建门禁：编译两遍 + 校验页数、缺字、Overfull
# 用法：bash scripts/check.sh
set -uo pipefail
cd "$(dirname "$0")/.."

TEX=resume-zh_CN.tex
LOG=resume-zh_CN.log
PDF=resume-zh_CN.pdf
EXPECT_PAGES=2

echo "== 编译（xelatex ×2）=="
for i in 1 2; do
  xelatex -interaction=nonstopmode -halt-on-error "$TEX" > "/tmp/resume-build-$i.log" 2>&1
  if [ $? -ne 0 ]; then
    echo "❌ 编译失败，日志：/tmp/resume-build-$i.log"
    tail -20 "/tmp/resume-build-$i.log"
    exit 1
  fi
done

echo "== 校验 =="
missing=$(grep -c "Missing character" "$LOG" 2>/dev/null || true)
overfull=$(grep -c "Overfull" "$LOG" 2>/dev/null || true)
pages=$(PDF="$PWD/$PDF" osascript -l JavaScript -e '
ObjC.import("PDFKit"); ObjC.import("Foundation");
var p = $.NSProcessInfo.processInfo.environment.objectForKey("PDF").js;
var d = $.PDFDocument.alloc.initWithURL($.NSURL.fileURLWithPath(p));
d.pageCount;
' 2>/dev/null || echo "?")

echo "页数: ${pages:-?}（期望 ${EXPECT_PAGES}）"
echo "缺字: ${missing:-0}"
echo "Overfull: ${overfull:-0}"

status=0
[ "$pages" = "$EXPECT_PAGES" ] || { echo "❌ 页数不符"; status=1; }
[ "${missing:-0}" = "0" ] || { echo "❌ 存在缺字（Missing character）"; status=1; }
[ "${overfull:-0}" = "0" ] || { echo "❌ 存在 Overfull（排版溢出）"; status=1; }
[ $status -eq 0 ] && echo "✅ 通过"
exit $status

# 简历版本存档

这里存放每一版简历定稿后的 PDF 快照。源码不另存 —— git 历史里都有，按下面的命令随时取回。

命名约定：`vN-YYYY-MM-DD.pdf`（N 为版本号，日期取定稿当天）。

| 版本 | 日期 | 说明 | PDF |
| --- | --- | --- | --- |
| v1 | 2025-04-22 | 最初提交的版本（`first commit`，ff5eb6f），使用当时的一寸照，2 页 | `v1-2025-04-22.pdf` |
| v2（当前） | 2026-10-24 | 换用现用一寸照，并完成内容改版（新增 AI 工程化方向、项目与荣誉、个人项目 JSONUtils 等）；源码与最新 PDF 在仓库根目录，本目录存 2026-10-24 快照 | `v2-2026-10-24.pdf` |

## 回溯旧版

```bash
# 历史版本 PDF（本目录各存一份）
open versions/v1-2025-04-22.pdf
open versions/v2-2026-10-24.pdf

# 旧版源码
git show ff5eb6f:resume-zh_CN.tex > resume-v1.tex

# 旧版照片
git show ff5eb6f:photo/photo.jpg > photo-v1.jpg

# 把整个 v1 提交导出成一个工作副本
git worktree add ../resume-v1 ff5eb6f
```

> 这些版本不为比较，只为回望来路。

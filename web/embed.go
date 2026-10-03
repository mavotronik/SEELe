package web

import "embed"

//go:embed index.html app.css app.js vendor assets
var Files embed.FS

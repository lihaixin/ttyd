# ttyd

```bash
docker run -itd -p 7681:7681 --name=ttyd --restart=always lihaixin/ttyd

加个登录和超时时间
docker run -itd -p 7681:7681 --name=ttyd --restart=always lihaixin/ttyd -c ttyd:password -P 3600 bash
```

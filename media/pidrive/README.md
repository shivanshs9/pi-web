# PiDrive

## Wormhole
Like wormhole.app, I have configured a dedicated folder for temporary file
uploads:

```bash
$ curl -fsSL https://pidrive.shivanshs9.me/public/wormhole?want=url -F f=@f.log
https://pidrive.shivanshs9.me/public/wormhole/f.log

# IF File is bigger than 100MB, then CF won't allow upload. In that case, split
the file:
split -b 95M FILE FILE.part.
for f in FILE.part.*; do
  curl -fsS -T "$f" \
    "https://pidrive.shivanshs9.me/public/wormhole/$f"
done
```

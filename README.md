# tinycord
A secure and lightweight alternative to the official Discord client.

## Releasing

1. Update version in `apps/desktop/src/version.zig` (also sync `apps/desktop/build.zig.zon`)
2. Commit and tag:
   ```sh
   git tag v<version>
   git push origin v<version>
   ```
3. CI builds macOS universal binary, packages as `.dmg`, publishes to GitHub Releases with auto-generated notes.

One artifact per release: `Tinycord_<version>_universal.dmg`

You can also trigger manually from Actions → Release Desktop App → Run workflow → enter tag.
# Changelog

All notable changes to this project will be documented in this file. See [commit-and-tag-version](https://github.com/absolute-version/commit-and-tag-version) for commit guidelines.

## 0.1.0 (2026-06-06)


### Features

* add BaseLayout, Page, Button, Badge, Card components ([72d0056](https://github.com/ilyeshdz/tinycord/commit/72d0056e03cd6a11c2e58c24163d293b06179f01))
* add Starlight website with GitHub Pages deployment ([2ec5470](https://github.com/ilyeshdz/tinycord/commit/2ec5470c7cd56b4a95393aed630e72d61a26f40d))
* group platform downloads by OS with per-architecture buttons ([02ae8a5](https://github.com/ilyeshdz/tinycord/commit/02ae8a5a3bb2c49502ce2bc5c460888248db0853))
* **macos:** enable microphone and camera access for Discord voice/video ([dbd7f3d](https://github.com/ilyeshdz/tinycord/commit/dbd7f3d4615e160b8ccd9484c0198874ed812466))
* setup website with astro + panda css ([3b6aaa7](https://github.com/ilyeshdz/tinycord/commit/3b6aaa739f5fc7490a8878de4d60c20cdde4410c))
* strip website to minimal landing page, drop multi-platform CI ([#15](https://github.com/ilyeshdz/tinycord/issues/15)) ([9c45e1e](https://github.com/ilyeshdz/tinycord/commit/9c45e1e4697f50e5906b8d75f0cf580020f982d1))


### Bug Fixes

* correct asset name patterns in download page ([06113fb](https://github.com/ilyeshdz/tinycord/commit/06113fbb26e6e6c0ec7482faa4b57e1942d7f7c9))
* hero link base path ([6fcbdd9](https://github.com/ilyeshdz/tinycord/commit/6fcbdd9222f0c0a3cf69cc041ad38deafba0b4da))
* point webview dep to fork with macOS cross-comp SDK fix ([83ceba4](https://github.com/ilyeshdz/tinycord/commit/83ceba45e68483db95dc0011153af21869169903))
* refactor download page to use Astro component for MDX compat ([628fa64](https://github.com/ilyeshdz/tinycord/commit/628fa64c6bafbed23d93f927079ab589e8c8e485))
* rename universal_binary -> universal_binaries (plural) ([d5f4f4f](https://github.com/ilyeshdz/tinycord/commit/d5f4f4f9060b0738e885fa3a8f62cfebcf901319))
* set astro base config via env for github pages sub-path ([e23ecfa](https://github.com/ilyeshdz/tinycord/commit/e23ecfa1e2953bd1c7eaed34068d3a970aebdfa1))
* update make-dmg.sh for goreleaser v2 universal binary path ([546c00e](https://github.com/ilyeshdz/tinycord/commit/546c00e4087dcd54f34005f28350b284b0abc3e7))
* use goreleaser v2 --skip=archive,publish syntax ([8cc6a96](https://github.com/ilyeshdz/tinycord/commit/8cc6a963c65da855a448b153bd5e4b7f02241147))
* use goreleaser v2 --skip=archive,publish syntax ([31d3d95](https://github.com/ilyeshdz/tinycord/commit/31d3d95b09e325c73e32523a2227d35a7b8e045b))
* **website:** make links BASE_URL-aware for subpath hosting ([e9c9b6f](https://github.com/ilyeshdz/tinycord/commit/e9c9b6ffd790cc96757a779c16e4a2acd00d62bd))

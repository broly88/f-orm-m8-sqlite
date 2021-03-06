---
name: Publish request
about: Publish master branch
title: 'Publish version x.x.x'
labels: 'publish'
assignees: ''

---

**Publish checklist**

- [ ] Update the src/pubspec.yaml with the required version
- [ ] Update the changelog
- [ ] Update documentation
  - [ ] README.md (+version sync)
  - [ ] src/README.md (+version sync)
  - [ ] example/README.md
- [ ] Format the code
  - [ ]  in src  ```dartfmt -w --fix src```
  - [ ]  in example ```dartfmt -w --fix example```
- [ ] Run tests 
  - [ ] ```cd src```
  - [ ] ```pub run test```
  - [ ] ```cd ..```
  - [ ] ```cd example```
  - [ ] ```flutter test```
  - [ ] ```flutter drive --target=test_driver/app.dart```
  - [ ] ```cd ..```
- [ ] Commit with message `#xxxx. Publish review completed`
- [ ] Merge develop changes into master
  - [ ] Check CI [results](https://travis-ci.org/matei-tm/f-orm-m8-sqlite) 
- [ ] Dry run
  - [ ] ```cd src```
  - [ ] ```pub publish --dry-run```
- [ ] Publish ```pub publish```
- [ ] Commit empty ```git commit --allow-empty -m "Completed publish closes #xxxx."```


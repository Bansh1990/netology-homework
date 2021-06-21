# Домашнее задание
1. ```git log --pretty=format:"%h - %an, %ar : %s" | grep aefea```
aefead220 - Alisdair McDiarmid, 1 год назад : Update CHANGELOG.md
2. ```git tag --points-at 85024d3``` v0.12.23
3. ```git rev-parse b8d720f8340221f2146e4e4870bf2ee0bc48f2d5^@```
56cd7859e05c36c06b56d013b55a252d0bb7e158
9ea88f22fc6269854151c571162c5bcf958bee2b

4. ````git log v0.12.23..v0.12.24 --pretty=oneline````

33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release

5. ```git log -S 'func providerSource(' --pretty=%H```
8c928e83589d90a031f811fae52a81be7153e82f
6. ```git log -S 'globalPluginDirs' --pretty=%H```
35a058fb3ddfae9cfee0b3893822c9a95b920f4c
c0b17610965450a89598da491ce9b6b5cbd6393f
8364383c359a6b738a436d1b7745ccdce178df47
   
7. ```git log -S 'synchronizedWriters' --pretty=format:"%h - %an, %ar : %s"```
5ac311e2a - Martin Atkins, 4 года, 2 месяца назад : main: synchronize writes to VT100-faker on Windows


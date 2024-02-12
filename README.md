## Cross-Chain communication

**The purpose of this repo is the study and development of a gateway responsible for cross-chain communication. We will use different cross-chain protocols such as WormHole, LayerZero, CCIP, and possibly Axelar.**



## Usage

### Build

```shell
$ forge build
```


### Deploy

```shell
$ forge script "script/DeployScript.s.sol:Deploy${network}" --rpc-url $NETWORK_RPC_URL --optimize
```
where network refers to BSCTESNET, FUJI, MUMBAI, etc...


### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

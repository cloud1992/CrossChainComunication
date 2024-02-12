// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

abstract contract DeployConfig {
    enum NETWORKS {
        BSC_TESTNET,
        MUMBAI,
        FUJI
    }

    address internal _wormholeRelayer;
    uint numbOfNetworks;
    uint[] networksChainId;
    uint16[] whormholeChainId;

    // config for each network
    constructor(NETWORKS network) {
        if (network == NETWORKS.BSC_TESTNET) {
            // whormhole relayer address
            _wormholeRelayer = 0x80aC94316391752A193C1c47E27D382b507c93F3;
            numbOfNetworks = 2;
            networksChainId = [80001, 1];
            whormholeChainId = [5, 2];
        } else if (network == NETWORKS.MUMBAI) {
            // whormhole relayer address
            _wormholeRelayer = 0x0591C25ebd0580E0d4F27A82Fc2e24E7489CB5e0;
            numbOfNetworks = 2;
            networksChainId = [97, 1];
            whormholeChainId = [4, 2];
        } else if (network == NETWORKS.FUJI) {
            // whormhole relayer address
            _wormholeRelayer = 0xA3cF45939bD6260bcFe3D66bc73d60f19e49a8BB;
            numbOfNetworks = 2;
            networksChainId = [97, 80001];
            whormholeChainId = [4, 5];
        }
    }
}

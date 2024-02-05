// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./GatewayStorage.sol";

abstract contract GatewayConfig is GatewayStorage {
    constructor(address initialOwner) GatewayStorage(initialOwner) {}

    // set onlyApproved
    function setOnlyApproved(address _addr, bool _status) external onlyOwner {
        _onlyApproved[_addr] = _status;
    }

    function setChainToLZChainId(
        uint chainId,
        uint16 lzChainId
    ) external onlyOwner {
        chainIdToLayerZeroChainId[chainId] = lzChainId;
        layerZeroChainIdToChainId[lzChainId] = chainId;
    }

    function setChainToWHChainId(
        uint chainId,
        uint16 whChainId
    ) external onlyOwner {
        chainIdToWormHoleChainId[chainId] = whChainId;
        wormHoleChainIdToChainId[whChainId] = chainId;
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "wormhole-solidity-sdk/interfaces/IWormholeRelayer.sol";
import "wormhole-solidity-sdk/interfaces/IWormholeReceiver.sol";

abstract contract WormHoleGateway is IWormholeReceiver {
    event WormHoleGatewayReceive(uint16 senderChain);

    IWormholeRelayer public immutable wormholeRelayer;

    constructor(address _wormholeRelayer) {
        wormholeRelayer = IWormholeRelayer(_wormholeRelayer);
    }

    function quoteCrossChainApp(
        uint16 targetChain,
        uint valueOnDst,
        uint gasOnDst
    ) public view returns (uint256 cost) {
        (cost, ) = wormholeRelayer.quoteEVMDeliveryPrice(
            targetChain,
            valueOnDst,
            gasOnDst
        );
    }

    function sendWormHole(
        uint16 targetChain,
        address targetAddress,
        bytes memory payload,
        uint valueOnDst,
        uint gasOnDst
    ) public payable {
        uint256 cost = quoteCrossChainApp(targetChain, valueOnDst, gasOnDst);
        require(msg.value >= cost);
        // send the payload to the wormhole
        wormholeRelayer.sendPayloadToEvm{value: cost}(
            targetChain,
            targetAddress,
            payload, // payload
            valueOnDst, // native token to send on destination
            gasOnDst // gas to use on destination
        );
    }

    function receiveWormholeMessages(
        bytes memory payload,
        bytes[] memory, // additionalVaas
        bytes32, // address that called 'sendPayloadToEvm' (HelloWormhole contract address)
        uint16 sourceChain,
        bytes32 // unique identifier of delivery
    ) public payable override {
        require(msg.sender == address(wormholeRelayer), "Only relayer allowed");
        _recieve(sourceChain, payload);
        emit WormHoleGatewayReceive(sourceChain);
    }

    function _recieve(uint srcChainId, bytes memory payload) internal virtual;
}

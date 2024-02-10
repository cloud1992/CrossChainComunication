// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./GatewayConfig.sol";
import "../WormHole/WormHoleGateway.sol";
import "./IGateway.sol";

contract Gateway is IGateway, GatewayConfig, WormHoleGateway {
    receive() external payable {}

    constructor(
        address _wormholeRelayer
    ) WormHoleGateway(_wormholeRelayer) GatewayConfig(msg.sender) {}

    // onlyApproved modifier
    modifier OnlyApproved() {
        require(_onlyApproved[msg.sender], "Gateway: not approved");
        _;
    }

    // send function
    function send(
        uint dstChainId,
        address to,
        string calldata text,
        uint valueOnDst,
        uint gasOnDst
    ) external payable OnlyApproved {
        // update nonce
        nonce++;
        // sendWormHole
        sendWormHole(
            chainIdToWormHoleChainId[dstChainId],
            to,
            abi.encode(text, msg.sender),
            valueOnDst,
            gasOnDst
        );
    }

    // internal function _receive
    function _recieve(uint srcChainId, bytes memory payload) internal override {
        // decode payload
        (string memory text, address from) = abi.decode(
            payload,
            (string, address)
        );
        latestText = text;
        srcChainId;
        from;
    }
}

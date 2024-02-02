// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./GatewayConfig.sol";
import "../WormHole/WormHoleGateway.sol";

contract Gateway is GatewayConfig, WormHoleGateway {
    receive() external payable {}

    constructor(address _wormholeRelayer) WormHoleGateway(_wormholeRelayer) {
        __Ownable_init(msg.sender);
    }

    // onlyApproved modifier
    modifier OnlyApproved() {
        require(_onlyApproved[msg.sender], "Gateway: not approved");
        _;
    }

    // send function
    function send(
        uint dstChainId,
        address to,
        bytes calldata adapterParams,
        bytes calldata payload
    ) external payable OnlyApproved {
        // do something
    }

    // internal function _receive
    function _receive(
        uint srcChainId,
        address from,
        bytes calldata adapterParams,
        bytes calldata payload
    ) internal {
        // do something
    }
}

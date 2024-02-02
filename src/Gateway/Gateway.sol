// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./GatewayConfig.sol";

contract Gateway is GatewayConfig {
    receive() external payable {}

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
    ) internal override {
        // do something
    }
}

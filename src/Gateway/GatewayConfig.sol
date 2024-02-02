// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./GatewayStorage.sol";

abstract contract GatewayConfig is GatewayStorage {
    // set onlyApproved
    function setOnlyApproved(address _addr, bool _status) external onlyOwner {
        _onlyApproved[_addr] = _status;
    }
}

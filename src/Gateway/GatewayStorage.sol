// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

abstract contract GatewayStorage is OwnableUpgradeable {
    /**Storage var */
    struct AdapterParams {
        address refound; // refound address
        uint nativeOnDst; // native token on destination
        uint gasOnDst; // gas on destination
    }

    // mapping for real chainId and protocol chainId
    // for whormhole
    mapping(uint => uint) public chainIdMapWhormHole;
    // for LayerZero
    mapping(uint => uint) public chainIdMapLayerZero;
    // mapping for onlyApproved
    mapping(address => bool) internal _onlyApproved;
}

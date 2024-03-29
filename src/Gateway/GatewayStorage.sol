// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract GatewayStorage is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {}

    /**Storage var */
    struct AdapterParams {
        address refound; // refound address
        uint nativeOnDst; // native token on destination
        uint gasOnDst; // gas on destination
    }
    // string to store latest text
    string public latestText;
    // enum for cross-chain provider (layerZero,, WhormHole...)
    enum CrossChainProvider {
        LayerZero,
        WhormHole
    }

    // mapping for real chainId and protocol chainId

    // for LayerZero
    mapping(uint => uint16) public chainIdToLayerZeroChainId;
    mapping(uint16 => uint) public layerZeroChainIdToChainId;

    // mapping for onlyApproved
    mapping(address => bool) internal _onlyApproved;

    uint nonce;
}

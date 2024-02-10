// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IGateway {
    function send(
        uint dstChainId,
        address to,
        string calldata text,
        uint valueOnDst,
        uint gasOnDst
    ) external payable;
}

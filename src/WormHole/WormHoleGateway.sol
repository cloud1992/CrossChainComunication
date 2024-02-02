import "wormhole-solidity-sdk/interfaces/IWormholeRelayer.sol";
import "wormhole-solidity-sdk/interfaces/IWormholeReceiver.sol";

contract WormHoleGateway is IWormholeReceiver {
    event WormHoleGateway(string greeting, uint16 senderChain, address sender);

    uint256 constant GAS_LIMIT = 50_000;

    IWormholeRelayer public immutable wormholeRelayer;

    string public latestGreeting;

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
            gasOnDst,
        );
    }

    function sendWormHole(
        uint16 targetChain,
        address targetAddress,
        bytes calldata payload
        uint valueOnDst,
        uint gasOnDst
    ) public payable {
        uint256 cost = quoteCrossChainApp(targetChain, valueOnDst, gasOnDst);
        require(msg.value >= cost);
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

        // Parse the payload and do the corresponding actions!
        (string memory greeting, address sender) = abi.decode(
            payload,
            (string, address)
        );
        latestGreeting = greeting;
        emit WormHoleGateway(latestGreeting, sourceChain, sender);
    }
}
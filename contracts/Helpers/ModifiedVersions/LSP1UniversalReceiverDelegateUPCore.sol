// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

import "./TokenAndVaultHandling.sol";

import "@openzeppelin/contracts/utils/introspection/ERC165Storage.sol";

import "./ILSP1UniversalReceiverDelegate.sol";

/**
 * @title Core Implementation of contract writing the received Vaults and LSP7, LSP8 assets into your ERC725Account using
 *        the LSP5-ReceivedAsset and LSP10-ReceivedVaults standard and removing the sent vaults and assets.
 *
 * @author Fabian Vogelsteller, Yamen Merhi, Jean Cavallera
 * @dev Delegate contract of the initial universal receiver
 *
 * Owner of the UniversalProfile MUST be a KeyManager that allows (this) address to setData on the UniversalProfile
 *
 */
abstract contract LSP1UniversalReceiverDelegateUPCoreV2 is
    ILSP1UniversalReceiverDelegate,
    ERC165Storage,
    TokenAndVaultHandlingContractV2
{
    /**
     * @inheritdoc ILSP1UniversalReceiverDelegate
     * @dev Allows to register arrayKeys and Map of incoming vaults and assets and removing them after being sent
     * @return result the return value of keyManager's execute function
     */
    function universalReceiverDelegate(
        address sender,
        bytes32 typeId,
        bytes memory data
    ) public override returns (bytes memory result) {
        if (
            typeId == _TYPEID_LSP7_TOKENSSENDER ||
            typeId == _TYPEID_LSP7_TOKENSRECIPIENT ||
            typeId == _TYPEID_LSP8_TOKENSSENDER ||
            typeId == _TYPEID_LSP8_TOKENSRECIPIENT ||
            typeId == _TYPEID_LSP9_VAULTSENDER ||
            typeId == _TYPEID_LSP9_VAULTRECIPIENT
        ) {
            result = _tokenAndVaultHandling(sender, typeId, data);
        }

        /* @TODO
          else if() {
            result = FollowerHandling(sender, typeId, data);
            }
        */
    }
}

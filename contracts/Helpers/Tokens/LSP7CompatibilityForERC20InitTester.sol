// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// modules
import {LSP7DigitalAsset} from "../../LSP7DigitalAsset/LSP7DigitalAsset.sol";
import {LSP7CompatibilityForERC20InitAbstract} from "../../LSP7DigitalAsset/extensions/LSP7CompatibilityForERC20InitAbstract.sol";

contract LSP7CompatibilityForERC20InitTester is LSP7CompatibilityForERC20InitAbstract {
    function initialize(
        string memory name,
        string memory symbol,
        address newOwner
    ) public virtual initializer {
        LSP7CompatibilityForERC20InitAbstract._initialize(name, symbol, newOwner);
    }

    function mint(
        address to,
        uint256 amount,
        bytes calldata data
    ) public {
        // using force=true so we can send to EOA in test
        _mint(to, amount, true, data);
    }

    function burn(
        address from,
        uint256 amount,
        bytes calldata data
    ) public {
        _burn(from, amount, data);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity > 0.8.0;

contract BalanceSheet {
    
    struct Asset {
        string label;
        uint amount;
    }

    struct Liability {
        string label;
        uint amount;
    }

    struct ShareholderEquity {
        string label;
        uint amount;
        uint liquidity;
    }

    enum typeofAsset {
        cash,
        marketableSecurity,
        accountsRecievable,
        longTermInvestment,
        longTermFixedAsset,
        intangibleAsset
    }

    enum typeofLiability {
        debt,
        wagesPayable,
        interestPayable,
        customerPrepayment   
    }

    address public owner;
    uint256 public totalAssets;
    uint256 public totalLiabilities;
    uint256 public equity;
        event AssetsUpdated(uint256 amount);
    event LiabilitiesUpdated(uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the contract owner.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
    
    function updateAssets(uint256 amount) public onlyOwner {
        totalAssets += amount;
        emit AssetsUpdated(amount);
    }

    function updateLiabilities(uint256 amount) public onlyOwner {
        totalLiabilities += amount;
        emit LiabilitiesUpdated(amount);
    }

    function calculateEquity() public view returns (int256) {
        return int256(totalAssets) - int256(totalLiabilities);
    }
}

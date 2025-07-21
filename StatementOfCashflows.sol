// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUSDC {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract CashFlowsStatement {
    mapping(address => int256) public cashFlows;
    address public usdcTokenAddress;  // Address of the USDC token contract
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    event CashFlowEvent(address indexed account, int256 amount);

    constructor(address _usdcTokenAddress) {
        usdcTokenAddress = _usdcTokenAddress;
        owner = msg.sender;
    }

    function recordCashFlow(int256 amount) external {
        require(amount != 0, "Amount cannot be zero");

        // Interaction with the USDC contract (this is hypothetical, adjust based on the actual USDC contract)
        IUSDC usdcToken = IUSDC(usdcTokenAddress);
        bool success = usdcToken.transferFrom(msg.sender, address(this), uint256(amount));

        require(success, "USDC transfer failed");

        cashFlows[msg.sender] += amount;
        emit CashFlowEvent(msg.sender, amount);
    }

    function withdrawUSDC(uint256 amount) external onlyOwner {
        IUSDC usdcToken = IUSDC(usdcTokenAddress);
        bool success = usdcToken.transfer(owner, amount);

        require(success, "Withdrawal failed");
    }
}

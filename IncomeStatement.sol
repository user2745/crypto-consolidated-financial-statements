// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract IncomeStatement {
    struct Revenue {
        string label;
        uint256 amount;
        bytes32 next;
        uint256 nonce;
    }

    struct Expense {
        string label;
        uint256 amount;
        bytes32 next;
        uint256 nonce;
    }

    // Hashmap of all revenues within the income statement
    mapping(uint256 => Revenue) public revenues;

    // Hashmap of all expenses within the income statement
    mapping(uint256 => Expense) public expenses;

    uint256 public inonce = 0;
    uint256 public enonce = 0;

    event RecordedIncome(string name, uint256 amount, uint256 nonce);
    event RecordedExpense(string name, uint256 amount, uint256 nonce);
    event GenerateNetIncome(address accountant, uint256 amount);

    address account;

    // Activities to be performed by an income statement

    function addRevenue(string memory name, uint256 amount)
        public
        returns (uint256)
    {
        inonce++;
        Revenue storage rev = revenues[inonce];
        rev.label = name;
        rev.amount = amount;
        rev.nonce = inonce;
        emit RecordedIncome(name, amount, inonce);
        return inonce;
    }

    function addExpense(string memory name, uint256 amount)
        public
        returns (uint256)
    {
        enonce++;
        Expense storage exp = expenses[enonce];
        exp.label = name;
        exp.amount = amount;
        exp.nonce = enonce;
        emit RecordedExpense(name, amount, enonce);
        return enonce;
    }

    function reportNetIncome() external returns (uint256) {
        uint256 netIncome;
        uint256 netExpenses;
        uint256 netRevenues;

        for (uint256 index = 0; index < inonce; index++) {
            Revenue memory item = revenues[inonce];
            netRevenues += item.amount;
        }

        for (uint256 index = 0; index < enonce; index++) {
            Expense memory item = expenses[enonce];
            netExpenses += item.amount;
        }

        // final outcome
        netIncome = netRevenues - netExpenses;
        emit GenerateNetIncome(msg.sender, netIncome);
        return netIncome;
    }

    // This checks the amount of USDC in an account
    function reportCashOnHand() external returns (uint256) {}

    // Transfer the cash in this account to another address.
    function transfer() external {}
}

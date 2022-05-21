// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract OwnCoin {
    string private _name;
    string private _symbol;
    mapping(address => uint256) private _balances;
    address private _owner;
    uint256 private _totalSupply;

    constructor(string memory name, string memory symbol) {
        require(bytes(name).length > 0, "OwnERCCoin: Need a coin name.");
        require(bytes(symbol).length > 0, "OwnERCCoin: Need a coin sysbol.");

        _name = name;
        _symbol = symbol;
        _totalSupply = 0;
        _owner = msg.sender;
    }

    function _mint(address account, uint256 amount) internal virtual{
        require(account != address(0), "account cannot be zero address.");
        require(amount > 0, "amount cannot be zero.");

        _totalSupply += amount;
        _balances[account] += amount;
    }

    //-------------
    //public function
     //-------------

    /**
    * @dev 獲取coin name
    * @return name 代幣名稱
    */
    function coinName() public view returns (string memory name) {
        return _name;
    }

    /**
    * @dev 獲取symbol
    * @return symbol 代幣縮寫
    */
    function symbolName() public view returns (string memory symbol) {
        return _symbol;
    }

    /**
    * @dev 查詢發行量
    * @return total 發行總量
    */
    function totalSupply() public view returns (uint256 total) {
        return _totalSupply;
    }
    
    /**
    * @dev 查詢指定帳號的餘額
    * @param account 查詢地址
    * @return blance 餘額
    */
    function balanceOf(address account) public view returns (uint256 blance) {
        require(account != address(0), "account cannot be zero address.");
        return _balances[account];
    }

    /**
    * @dev 轉帳給指定地址
    * @param to 接收者
    * @param amount 數量
    * @return result 轉帳是否成功
    */
    function transfer(address to, uint256 amount) public payable returns (bool result) {
        
        uint256 senderBalance = _balances[msg.sender];

        //判斷傳送者餘額是否足夠
        if (senderBalance >= amount)
        {
            _balances[msg.sender] -= amount;
            _balances[to] += amount;
            return true;
        }
        
        return false;
    }
}

contract TestCoin is OwnCoin {
   constructor() OwnCoin("Test Coin", "TC") {
        _mint(msg.sender, 10000);
   }
}
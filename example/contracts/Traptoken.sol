pragma solidity 0.5.0;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/AccessControl.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/AccessControlEnumerable.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Capped.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/Pausable.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/PullPayment.sol";


//import "https://github.com/aragon/zeppelin-solidity/blob/master/contracts/token/StandardToken.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
contract ERC20Interface {
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

// ----------------------------------------------------------------------------
// Safe Math Library
// ----------------------------------------------------------------------------
contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a); c = a - b; } function safeMul(uint a, uint b) public pure returns (uint c) { c = a * b; require(a == 0 || c / a == b); } function safeDiv(uint a, uint b) public pure returns (uint c) { require(b > 0);
        c = a / b;
    }
    
}
contract Traptoken is ERC20Interface, SafeMath {
    string public name;
    string public symbol;
    uint8 public decimals; // 18 decimals is the strongly suggested default, avoid changing it
    uint256 public _totalSupply;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    /**
     * Constrctor function
     *
     * Initializes contract with initial supply tokens to the creator of the contract
     */
constructor() public {
        name = "TrapToken";
        symbol = "Trap";
        decimals = 18;
        _totalSupply = 100000000000000000000000000;

        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view returns (uint) {
        return _totalSupply  - balances[address(0)];
    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }
}


/** 
*/


/** Sometimes, in order to extend a parent contract you will need to override multiple related functions, which leads to code duplication and increased likelihood of bugs.
For example, consider implementing safe ERC20 transfers in the style of IERC721Receiver. You may think overriding transfer and transferFrom would be enough, but what about _transfer and _mint? To prevent you from having to deal with these details, we introduced hooks.
Hooks are simply functions that are called before or after some action takes place. They provide a centralized point to hook into and extend the original behavior.
Here’s how you would implement the IERC721Receiver pattern in ERC20, using the _beforeTokenTransfer hook: */
/** contract ERC20WithSafeTransfer is ERC20 {
  function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
    super._beforeTokenTransfer(from, to, amount); //call parent hook w/IERC721 "SafeTransfer"

    require(_validRecipient(to), "ERC20WithSafeTransfer: invalid recipeint");
  }
  function _validRecipient(address to) private view returns (bool) { }
    /** insert logic here */
 
  /** insert logic here */

/**
* @title TrapToken is  BasicERC20 Token
*/

/**
 * contract ERC20WithAutoMinerReward is ERC20 {
  constructor() ERC20("Reward", "RWD") {}

  function _mintMinerReward() internal {
    _mint(block.coinbase, 100000000);
  }
  function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual override {
    _mintMinerReward();
    super._beforeTokenTransfer(from, to, value);
  }
 */
/** 
 * contract TrapToken {

    address public owner;
    
    mapping (address => uint) public balances;
    
    event Transfer(address from, address to, uint amount);
    
    
    constructor() public {
        owner = msg.sender;
    }
    
  function mint(address receiver, uint amount) public {
       require(msg.sender == owner, "You are not the owner.");
       
       require(amount <1e60, "Maximum issuance succeeded");
       
       balances[receiver] += amount;
  }
  
  function transfer(address receiver, uint amount) public {
      
      require(amount <= balances[msg.sender], "Insufficient balance.");
      
      balances[msg.sender] -=amount;
      balances[receiver] +=amount;
      
      emit Transfer(msg.sender, receiver, amount);
  }
  
      //receive ether
    function fallback () public payable {}
    
    //function receive() public payable {}
}


contract MiinerRewardMinter {
  ERC20PresetMinterPauser _token;

  constructor(ERC20PresetMinterPauser token) {
    _token = token;
  }
  function mintMinerReward() public {
    _token.mint(block.coinbase, 100000000);
  }
}
*/

/** contract ERC20WithAutoMinerReward is ERC20 {
  constructor() ERC20("Reward", "RWD") {}

  function _mintMinerReward() internal {
    _mint(block.coinbase, 100000000);
  }
  function _beforeTokenTransfer(address from, address to, uint256 value) internal virtual override {
    _mintMinerReward();
    super._beforeTokenTransfer(from, to, value);
  }
  */
pragma solidity >= 0.8.0;

contract Token {
  string public name;                   // name of token
  string public symbol;                 // symbol of the token
  uint8 public decimals;               // decimal pieces of the token
  uint256 public totalSupply;           // total supply of tokens
  address payable public owner;         // owner of tokens

  /** mapping with all balances */
  mapping (address => uint256) public balanceOf;

  /** mapping with accounts with allowances */
  mapping (address => mapping (address => uint256)) public allowance;

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approve(address indexed owner,  address indexed spender, uint256 value);

  constructor() {
    name = "";
    symbol = "";
    decimals = 10;
    uint256 _initialSupply = 1000000000000;

    owner = payable(msg.sender);

    balanceOf[owner] = _initialSupply;
    totalSupply = _initialSupply;

    emit Transfer(address(0), msg.sender, _initialSupply);
  }

  function getOwner() public view returns (address) {
    return owner;
  }

  function transfer(address _to, uint256 _value) public returns (bool success) {
    uint256 senderBalance = balanceOf[msg.sender];
    uint256 receiverBalance = balanceOf[_to];

    require(_to != address(0), "Receiver address invalid");
    require(_value >= 0, "Value must be greater or equal to 0");
    require(senderBalance > _value, "Not enough balance");

    balanceOf[msg.sender] = senderBalance - _value;
    balanceOf[_to] = receiverBalance + _value;

    emit Transfer(msg.sender, _to, _value);

    return true;
  }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    // uint256 senderBalance = balanceOf[msg.sender];
    // uint256 fromAllowance = allowance[_from][msg.sender];
    // uint256 receiverBalance = balanceOf[_to];

    // require(_to != address(0), "Receiver address invalid");
    // require(_value >= 0, "Value must be greater or equal to 0");
    // require(senderBalance > _value, "Not enough balance");
    // require(fromAllowance >= _value, "Not enough allowance");

    // balanceOf[_from] = senderBalance - _value;
    // balanceOf[_to] = receiverBalance + _value;
    // allowance[_from][msg.sender] = fromAllowance - _value;

    // emit Transfer(_from, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value) public returns (bool success) {
    require(_value > 0, "Value must be greater than 0");

    allowance[msg.sender][_spender] = _value;
    
    emit Approve(msg.sender, _spender, _value);
    return true;
  }

  function mint(uint256 _amount) public returns (bool success) {
    require(msg.sender == owner, "Operation is unauthorized");

    totalSupply += _amount;
    balanceOf[msg.sender] += _amount;

    emit Transfer(address(0), msg.sender, _amount);
    return true;
  }

  function burn(uint256 _amount) public returns (bool success) {
    require (msg.sender != address(0), "Invalid burn recipient");

    uint256 accountBalance = balanceOf[msg.sender];
    require(accountBalance > _amount, "Burn amount exceeds balance");

    balanceOf[msg.sender] -= _amount;
    totalSupply -= _amount;

    emit Transfer(msg.sender, address(0), _amount);
    return true;
  }



}
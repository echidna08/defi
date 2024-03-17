
// SPDX-License-Identifier: GPL-3.0-or-later


pragma solidity  ^0.8.24 ;


contract will {
    //증여자의 주소
     address owner;
    uint    fortune ;
    bool    deceased;

    constructor() payable   {
        owner =msg.sender; //호출된 주소를 나타내는 sender 를 소유자로 정하는것 
        fortune =msg.value; //전송하는 이더의 양 (유산) 
        deceased = false;  

    }
//제어자 
    modifier onlyOwner {
        require(msg.sender == owner ); //조건문 같은거임
        _;
    }
    modifier mustBeDeceased {
        require(deceased == true ); //조건문 같은거임
        _;
    }

//배열생성
    address payable[] familyWallets ;
    
    mapping(address => uint) inheritance ;
    
    function setInheritance(address payable wallet, uint amount)public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = amount ;
        
    }


    function payout() private mustBeDeceased { //상속자가 죽었을때 (제어자 ) 
        for(uint i=0; i<familyWallets.length;i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }

        
        
    }
    //oracle switch simulation
    function hasDeceased() public onlyOwner{
        deceased = true;
        payout();
    }
    
}
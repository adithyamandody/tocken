import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter  "mo:base/Iter";


actor Token{

    var owner : Principal = Principal.fromText("rvipp-o7nul-e65oz-hzjwm-vesrh-ko3su-iasos-7pvl7-yypla-uj6f4-fae");
    var totalSupply:Nat=1000000;
    var symbol :Text="ADI";

    private stable var balanceEntries: [(Principal,Nat)]=[];
    private var balances=HashMap.HashMap<Principal,Nat>(1,Principal.equal,Principal.hash);

    if(balances.size() < 1){
        balances.put(owner,totalSupply);
    };

    
    public query func balanceOf(who: Principal):async Nat{

        let balance:Nat=switch(balances.get(who)){
            case null 0;
            case (?result) result;  
        };
        return balance;
    };
        public shared(msg) func payOut(): async Text{
            if (balances.get(msg.caller)==null){
                    let amount =10000;
                    let result = await transfer(msg.caller,amount );
                    return result;
            } else {
                    return "already Claimed";
                }
        };
        public shared(msg) func transfer( to:Principal, amount:Nat): async Text{
            let fromBalance= await balanceOf(msg.caller);
            if(fromBalance > amount){
                let newFromBalance:Nat=fromBalance-amount;
                balances.put(msg.caller,newFromBalance);


                let toBalance=await balanceOf(to);
                let newToBalance=toBalance+amount;
                balances.put(to,newToBalance); 
                return "success";
            } else{
                return"insufficient fund";
            }
        };

        system func preupgrade(){
            balanceEntries:=Iter.toArray(balances.entries());

            
        };


        system func postupgrade(){
            balances:=HashMap.fromIter<Principal,Nat>(balanceEntries.vals(),1,Principal.equal,Principal.hash);
            if(balances.size() < 1){
        balances.put(owner,totalSupply);

            };
        };
    
};

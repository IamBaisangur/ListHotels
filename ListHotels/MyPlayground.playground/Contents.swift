let str = ["weesdf", "weefg", "weesfdb", "weeknl", "weefnlm"]

func longestCommonPrefix(_ strs: [String]) -> String {
    if strs.count == 0 { return "" }
   
    var minStr = (strs.min{$0.count < $1.count})!
    print(minStr)
    
    for str in strs{
        while !str.hasPrefix(minStr){
             minStr.removeLast()
        }
    }
    
    return minStr
}

longestCommonPrefix(str)

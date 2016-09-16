import re

def patron():
    line = "ROTRV V5 V9 R15"
    registros = "([0-9]?[0-5]?[A-F]*)"
    operandos = " ?((V|R|#)"+registros+")?"
    regex = r"([A-Z]+)" + operandos + operandos + operandos
    matchObj = re.match(regex, line)

    if (matchObj):
        function = matchObj.group(1)
        if ((function == "ADDV")  | (function == "SUBV") | (function == "XORV") | (function == "ANDV") | (function == "ORV")):
            operand1 = matchObj.group(4)
            operand2 = matchObj.group(7)
            operand3 = matchObj.group(10)
            
            opcode = obtenerOpCode(function)
            Vk     = obtenerBinario(int(operand1), '4')
            Vw     = obtenerBinario(int(operand2), '4')
            Vz     = obtenerBinario(int(operand3), '4')
            
            return opcode +" "+ Vk +" "+ Vw +" "+ Vz + " 000000000000000"
        elif ((function == "LDV") | (function == "STV")):
            operand1 = matchObj.group(4)
            operand2 = matchObj.group(7)
            if (matchObj.group(6) == "R"):
                operand3 = matchObj.group(10)
            
                opcode = obtenerOpCode(function+"r")
                Vk  = obtenerBinario(int(operand1), '4')
                Rw  = obtenerBinario(int(operand2), '4')
                imm = obtenerBinario(int(operand3, 16), '19')

                return opcode +" "+ Vk +" "+ Rw +" "+imm
            else: #immediate
                opcode = obtenerOpCode(function+"i")

                Vk = obtenerBinario(int(operand1), '4')
                Rw = obtenerBinario(0, '4')
                imm = obtenerBinario(int(operand2, 16), '19')
                
                return opcode +" "+ Vk +" "+ Rw +" "+imm
        elif ((function == "MOVS") | (function == "MOVV")):
            operand1 = matchObj.group(4)
            operand2 = matchObj.group(7)
            if ((matchObj.group(6) == "V") | (matchObj.group(6) == "R")):
                opcode = obtenerOpCode(function+"r")
                Rk  = obtenerBinario(int(operand1), '4')
                Rw  = obtenerBinario(int(operand2), '4')
                imm = obtenerBinario(0, '19')

                return opcode +" "+ Rk +" "+ Rw +" "+imm
            else: # immediate
                opcode = obtenerOpCode(function+"i")

                Rk  = obtenerBinario(int(operand1), '4')
                Rw  = obtenerBinario(0, '4')
                imm = obtenerBinario(int(operand2, 16), '19')
                
                return opcode +" "+ Rk +" "+ Rw +" "+imm 
        else: # desplazamiento
            operand1 = matchObj.group(4);
            operand2 = matchObj.group(7);
            operand3 = matchObj.group(10)
            
            if ((matchObj.group(9) == "R")):                

                opcode = obtenerOpCode(function)                
                Vk     = obtenerBinario(int(operand1), '4')
                Vw     = obtenerBinario(int(operand2), '4')
                Rz     = obtenerBinario(int(operand3), '4')
                bitDes = "0"
                imm    = obtenerBinario(0, '14')

                return opcode +" "+ Vk +" "+ Vw +" "+ Rz +" "+ bitDes +" "+ imm
            else: #inmediato
                opcode = obtenerOpCode(function)                
                Vk     = obtenerBinario(int(operand1), '4')
                Vw     = obtenerBinario(int(operand2), '4')
                Rz     = obtenerBinario(0, '4')
                bitDes = "1"
                imm    = obtenerBinario(int(operand3), '14')

                return opcode +" "+ Vk +" "+ Vw +" "+ Rz +" "+ bitDes +" "+ imm
    else:
        print ("No match")

def obtenerBinario(numero, cantidad):
    formato = '{0:'+cantidad+'b}'
    return formato.format(numero).replace(" ","0")


def obtenerOpCode(function):
    options = {"NOP"   : "00000",
               "ADDV"  : "00001",
               "SUBV"  : "00010",
               "XORV"  : "00011",
               "ANDV"  : "00100",
               "ORV"   : "00101",
               "LDVi"  : "00110",
               "LDVr"  : "00111",
               "STVi"  : "01000",
               "STVr"  : "01001",
               "MOVSi" : "01010",
               "MOVSr" : "01011",
               "MOVVi" : "01100",
               "MOVVr" : "01101",
               "SHLV"  : "01110",
               "SHRV"  : "01111",
               "ROTLV" : "10000",
               "ROTRV" : "10001"}
    return options[function]
    
    

print(patron())

"""Converte um charmap .mif (formato Quartus, linhas sem TAB) para o formato
que o simulador ICMC consegue ler (cada linha de dados comeca com um TAB).
 
Uso: python3 converte_charmap.py entrada.mif saida.mif
"""
import re, sys
 
def main(entrada, saida):
    txt = open(entrada, errors="ignore").read().replace("\r", "")
 
    width = int(re.search(r"WIDTH\s*=\s*(\d+)", txt).group(1))
    depth = int(re.search(r"DEPTH\s*=\s*(\d+)", txt).group(1))
 
    corpo = txt.split("CONTENT BEGIN", 1)[1].split("END;", 1)[0]
    mem = [None] * depth
    # aceita "A:bits;", "[A..B]:bits;" com espacos/TABs em qualquer lugar
    padrao = re.compile(r"\[?\s*(\d+)\s*(?:\.\.\s*(\d+)\s*)?\]?\s*:\s*([01]+)\s*;")
    for a, b, bits in padrao.findall(corpo):
        a = int(a); b = int(b) if b else a
        if len(bits) != width:
            sys.exit(f"Linha com largura {len(bits)} != WIDTH={width}: {a}..{b}")
        for i in range(a, b + 1):
            mem[i] = bits
 
    faltando = [i for i, v in enumerate(mem) if v is None]
    if faltando:
        sys.exit(f"{len(faltando)} enderecos sem valor (primeiro: {faltando[0]})")
 
    with open(saida, "w", newline="") as f:
        f.write("-- Charmap convertido\r\n\r\n")
        f.write(f"WIDTH={width};\r\nDEPTH={depth};\r\n\r\n")
        f.write("ADDRESS_RADIX=UNS;\r\nDATA_RADIX=BIN;\r\n\r\n")
        f.write("CONTENT BEGIN\r\n")
        for i, bits in enumerate(mem):
            f.write(f"\t{i}:{bits};\r\n")
        f.write("END;\r\n")
    print(f"OK: {depth} posicoes ({depth // 8} caracteres) gravadas em {saida}")
 
if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
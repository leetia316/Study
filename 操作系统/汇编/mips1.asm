# func fact(int n) {
# 	if (n == 0) {
#		return 1
#	}
# 	return fact(n-1) * n
#}

# ��ʼ�ݹ麯������

addiu $sp, $0, 0x10010080 # ��ʼ�� $sp ��ַ

addiu $s0, $0, 5 # n = 5 # ��ʼ�� s0 = 5
# ��ջ����
sw $s0, 0($sp) # �� $s0 �Ĵ����е�ֵ д��ָ�� $sp ƫ����Ϊ0�ĵ�ַ sp = s0 = 5
addiu $sp, $sp, -4 # ָ���ַ-4 $sp ָ���µ�ַ��ֵδ֪

jal FACT # ��ת�� FACT ��ǩ(������)
nop # ��һ��ʲô������(��һ��ִ�����ִ����һ�в�ȥ��ת
j END # �����������ص���һ������ת������

FACT:

# ѹջ���ص�ַ (����λ��
sw $ra, 0($sp)
addiu $sp, $sp, -4

# ��ȡ���
lw $s0, 8($sp) # ��ȡ$spƫ����Ϊ8��ֵ�� $s0 �Ĵ��� s0 = 5

# ѹջ����ֵ (��Ȼ����ֵδ֪������ռȡλ��
sw $0, 0($sp)
addiu $sp, $sp, -4

# �ݹ� base ����
# if ( n == 0 ) { return 1 }
bne $s0, $0, RECURSION # ������������� 0 ����ת�� RECURSION ��ǩ
nop
lw $t1, 8($sp) # ��ȡ���ص�ַ
# ��ջ: ����ֵ, ���ص�ַ
addiu $sp, $sp, 8
# ѹջ����ֵ
addiu $s0, $zero, 1
sw $s0, 0($sp)
addiu $sp, $sp, -4

jr $t1
nop

RECURSION: # recursion
# return fact(n-1) * n

# ѹջ����
addiu $s1, $s0, -1
sw $s1, 0($sp)
addiu $sp, $sp, -4

jal FACT
nop

# ���ڵ�ջ��ʲô���ӵģ� ���� | ���������ص�ַ | ����������ֵ | �Ӻ����Ĳ��� | �Ӻ����ķ���ֵ | ��ǰSP
# return fact(n-1) * n
# ��ǰ����
lw $s0, 20($sp)
# �Ӻ�������ֵ
lw $s1, 4($sp)
# ���ص�ַ
lw $t1, 16($sp)

mult $s1, $s0 # �˷���浽lo�Ĵ�����
mflo $s2 # ��lo�Ĵ�����ȡ������$s2

# ��ջ(ָ��ص��������ķ��ص�ַ
addiu $sp, $sp, 16

# ����ֵѹջ
sw $s2, 0($sp)
addiu $sp, $sp, -4

jr $t1 # �ص�������ִ�е�λ��
nop

END:
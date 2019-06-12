function Code = ShannonCode(Prob, Len)
%ShannonCode ���ۼӸ��ʱ�Ϊ����������ȡС�������볤��λΪ����
%   Code = ShannonCode(Prob, Len)
%   Prob    :  �ۼӸ���
%   Len     :  �����鳤��
%   Code    :  ����

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    N = length(Prob);
    Code = cell(N, 1);
    for n = 1 : N
        num = Prob(n);
        code = zeros(1, Len(n));
        for i = 1 : Len(n)
            num = num * 2;
            if (num >= 1)
                code(i) = 1;
                num = num - 1;
            end
        end

        strCode = '';
        for i = 1 : Len(n)
            strCode = strcat(strCode, num2str(code(i)));
        end
        Code{n, 1} = strCode;
    end
end
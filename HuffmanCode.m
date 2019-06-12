function [Code, codeLen, trace] = HuffmanCode(process, r, fullLen, theta, originalLen)
%HuffmanCode ͨ��������̵õ���������
%   [Code, codeLen, trace] = HuffmanCode(process, r, fullLen, theta, originalLen)
%   process     :  �������
%   r           :  rԪ����������
%   fullLen     :  ������Ÿ���
%   theta       :  ��Դ��������
%   originalLen	:  ��ʼ���Ÿ���
%   Code        :  ����
%   codeLen     :  �볤
%   trace       :  �������

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
	trace = cell(fullLen, (theta+1));
    for j = (theta + 1) : -1 : 1
        % �������루ĩβλ��0��1��2���룩
        tempS = process{j, 1};
        tempLen = length(tempS);
        for k = (tempLen - r + 1) : tempLen
            trace{k, j} = strcat(num2str(trace{k, j}), num2str(k - tempLen + r - 1));
        end

        % ��ǰһ������
        tempNum = process{j, 2};
        if(~isnan(tempNum))
            for l = 1 : tempNum
                trace{l, j - 1} = trace{l, j};
            end
            for l = tempNum : (tempLen - 1)
                trace{l, j - 1} = trace{(l + 1), j};
            end
            for l = tempLen : (tempLen + r - 1)
                trace{l, j - 1} = trace{tempNum, j};
            end
        end
    end

    % ��������鳤��
    Code = trace(1 : originalLen, 1);
    codeLen = zeros(1, originalLen);
    for i = 1 : originalLen
        codeLen(i) = length(Code{i});
    end
end
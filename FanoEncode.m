function [Code, averLen, Eta, process] = FanoEncode(Prob)
%FanoEncode ��ŵ����
%   [Code, averLen, Eta] = FanoEncode(Prob)
%   Prob        :  ������Ϣ����
%   Code        :  ����
%   averLen     :  ƽ�����ų���
%   Eta         :  ����Ч��
%   process     :  �������

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    len = length(Prob);
    % �ݼ���������
    sortProb = sort(Prob, 'descend');

    % ��ŵ����
    group = FanoDivision(sortProb, cell(len, 1));
    for i = 2 : size(group, 2)
        for j = 1 : len
            if(isempty(group{j, i}))
                group{j, i} = group{j, i - 1};
            end
        end
    end
    Code = group(:, size(group, 2));
    process = group(:, 2 : end);
    % ����ƽ���볤������Ч��
    codeLen = zeros(1, len);
    for i = 1 : len
        codeLen(i) = length(Code{i, 1});
    end
    averLen = sum(codeLen .* sortProb);
    IProb = -log2(sortProb);
    H = sum(IProb .* sortProb);
    Eta = H / averLen;
    
%     fprintf('��ŵ���룺');
%     fprintf('ƽ���볤Ϊ��%.2f ��Ԫ/���ţ���Դ��Ϊ��%.2f bit/���ţ�����Ч��Ϊ��%.1f%%\n', averLen, H, Eta * 100);
end
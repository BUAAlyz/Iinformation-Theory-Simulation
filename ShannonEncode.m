function [Code, averLen, Eta] = ShannonEncode(Prob)
%ShannonEncode ��ũ����
%   [Code, averLen, Eta] = ShannonEncode(Prob)
%   Prob        :  ������Ϣ����
%   Code        :  ����
%   averLen     :  ƽ�����ų���
%   Eta         :  ����Ч��

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    len = length(Prob);
    % �ݼ���������
    sortProb = sort(Prob, 'descend');

    % �����ۼӸ���
    cumulateProb = zeros(1, len);
    for i = 1 : (len - 1)
        cumulateProb(i + 1) = cumulateProb(i) + sortProb(i);
    end

    % ��������鳤��
    IProb = -log2(sortProb);
    codeLen = ceil(IProb);

    % ��ũ����
    Code = ShannonCode(cumulateProb, codeLen);

    % ����ƽ���볤������Ч��
    averLen = sum(codeLen .* sortProb);
    H = sum(IProb .* sortProb);
    Eta = H / averLen;
    
%     fprintf('��ũ���룺');
%     fprintf('ƽ���볤Ϊ��%.2f ��Ԫ/���ţ���Դ��Ϊ��%.2f bit/���ţ�����Ч��Ϊ��%.1f%%\n', averLen, H, Eta * 100);
end
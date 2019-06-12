function [Code, averLen, Eta, process] = HuffmanEncode(Prob, r)
%HuffmanEncode ����С�뷽�����������
%   [Code, averLen, Eta, trace] = HuffmanEncode(Prob, r)
%   Prob        :  ������Ϣ����
%   r           :  rԪ����������
%   Code        :  ����
%   averLen     :  ƽ�����ų���
%   Eta         :  ����Ч��
%   process     :  �������

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    % ������Ÿ�����ʹ֮����q = (r - 1) * �� + r
    len = length(Prob);
    theta = ceil((len - r) / (r - 1));
    q = theta * (r - 1) + r;
    newProb = Prob;
    for i = (len + 1) : q
        newProb(i) = 0;
    end
    % �ݼ���������
    sortProb = sort(newProb, 'descend');

    % ����Ԥ���̣�s(i, 1)Ϊ�������̣�s(i, 2)Ϊ��������λ��
    s = cell(theta + 1, 2);
    s{1, 1} = newProb;
    s{1, 2} = NaN;
    for i = 1 : theta
        tempMat = sort(cell2mat(s(i)), 'descend');
        tempLen = length(tempMat);
        temp = sum(tempMat(tempLen - r + 1 : tempLen));
        % �ҵ�������÷ŵ�λ��
        for j = 1 : (tempLen - r + 1)
            if(temp >= tempMat(j))
                s{i + 1, 2} = j;
                break
            end
        end
        newMat = [temp, tempMat(1 : (tempLen - r))];
        s{i + 1, 1} = sort(newMat, 'descend');
    end

    % ����������
    [Code, codeLen, process] = HuffmanCode(s, r, q, theta, len);

    % ����ƽ���볤������Ч��
    averLen = sum(codeLen .* sortProb(1 : len));
    IProb = -log2(Prob);
    H = sum(IProb .* Prob);
    Eta = H / (averLen * log2(r));
    
%     fprintf('���������룺');
%     fprintf('ƽ���볤Ϊ��%.2f ��Ԫ/���ţ���Դ��Ϊ��%.2f bit/���ţ�����Ч��Ϊ��%.1f%%\n', averLen, H, Eta * 100);
end
function process = FanoDivision(Group, process, divNum, deviation)
%Division �ѽ�����������а������ܵȸ��ʷ�Ϊ����
%   process = FanoDivision(Group, process, divNum)
%   Group       :  ������Ϣ��������
%   process     :  ������̣������£�
%   divNum      :  ���������Ĭ��ֵΪ1
%   deviation   :  ��ʼֵ��ƫ��ֵ����Ĭ��ֵΪ1

%   Author      :  TT
%   Date        :  2019.5.21
%------------------------------------------------------------------------------
    if(~exist('divNum', 'var'))
        divNum = 1;
    end
    if(~exist('deviation', 'var'))
        deviation = 1;
    end
    
    % ��ʼֵ
    len = length(Group);
    up = Group(1);
    upNum = 1;
    down = Group(end);
    downNum = len;
    process{upNum + deviation - 1, divNum + 1} = strcat(process{upNum + deviation - 1, divNum}, '0');
    process{downNum + deviation - 1, divNum + 1} = strcat(process{downNum + deviation - 1, divNum}, '1');
    divUpGroup(upNum) = Group(upNum);
    divDownGroup(len - downNum + 1) = Group(downNum);
    % �Ƚ������ִ�С����С�Ĳ��ֺϲ��µ���
    while( (downNum - upNum) > 1)
        if(up < down)
            upNum = upNum + 1;
            up = up + Group(upNum);
            process{upNum + deviation - 1, divNum + 1} = strcat(process{upNum + deviation - 1, divNum}, '0');
            divUpGroup(upNum) = Group(upNum);
        else
            downNum = downNum - 1;
            down = down + Group(downNum);
            process{downNum + deviation - 1, divNum + 1} = strcat(process{downNum + deviation - 1, divNum}, '1');
            divDownGroup(len - downNum + 1) = Group(downNum);
        end
    end
    % ��������
    divUpGroup = sort(divUpGroup, 'descend');
    divDownGroup = sort(divDownGroup, 'descend');
    
    % �ݹ����
    if(length(divUpGroup) > 1)
        process = FanoDivision(divUpGroup, process, divNum + 1, deviation);
    end
    if(length(divDownGroup) > 1)
        process = FanoDivision(divDownGroup, process, divNum + 1, downNum + deviation - 1);
    end
end
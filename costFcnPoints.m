function [l, delta] = costFcnPoints(p_a, p_b)      
          lsquare =(1/length(p_a))*sum(sum((p_a-p_b).*(p_a-p_b),2));
          delta = (1/length(p_a))*sum((sum((p_a-p_b).*(p_a-p_b),2)-lsquare).*(sum((p_a-p_b).*(p_a-p_b),2)-lsquare));
          l = sqrt(lsquare);
    end
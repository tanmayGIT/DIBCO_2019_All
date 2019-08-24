function [ worst_confs,dif ] = friedman_test( c, flagMaior )
% c -> resultados funcao objetivo
% linhas : configurações
% colunas : instancias de entrada
% res == 1 -> hipótese nula rejeitada - ao menos uma configuração possui 
%resultados significativamente melhores do que ao menos uma configuração
%res == 0 -> hipotese nula não rejeitada. nenhuma configuração deve ser
%eliminada
alpha = 0.1;
worst_confs = [];
%gera rankings
r = zeros(size(c));
k = size(c,2);
for config = 1:size(c,1)
    for inst = 1 : size(c,2)
        if(flagMaior == 1)
        r(config,inst) = numel(find(c(:,inst) >= c(config,inst)));
        else
           r(config,inst) = numel(find(c(:,inst) <= c(config,inst))); 
        end
    end
end

%%rj - soma dos rankings de cada configuração
rj = c(:,1);
for config = 1:size(c,1)
    rj(config) = sum(r(config,:));
end 

%calcula T
m = numel(rj);


num = 0;
for config = 1 : m
    num = num + (rj(config)-(k*(m+1)/2))^2;
end
num = (m-1)*num;

den = 0;

for config = 1:size(r,1)
    for inst = 1 : size(r,2)
        den = den + r(config,inst)^2;
    end
end
den = den - (k*m*(m+1)^2)/4;
t = num/den;

if(t>tquant(m-1,1-alpha))
    dif = 1;
else
    dif = 0;
    return;
end

% testa a melhor configuração contra todas as outras para 
% decidir quais serão excluidas

best_rj = min(rj);

for i = 1 : numel(rj)
    if(rj(i) == best_rj)
        
        continue;
    end
    
    res_comp_par = (abs(best_rj - rj(i)))/sqrt( 2*k*abs(1-t/(k*(m-1))) * den/((k-1)*(m-1)) );
    x = tquant(m-1,1-alpha/2);
    if(res_comp_par > x)
        worst_confs = [worst_confs ; i];
    end
    
end



end


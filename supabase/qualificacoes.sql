-- Tabela de respostas do quiz de qualificação (qualificacao/index.html)
-- Rodar no SQL Editor do Supabase (projeto pzwnvuypmwsgnoihkxzq).

create table if not exists public.qualificacoes (
  id               uuid primary key default gen_random_uuid(),
  created_at       timestamptz not null default now(),
  nome             text not null,
  email            text not null,
  telefone         text not null,
  incorporadora    text not null,
  vgv              text not null,  -- faixa do VGV do lançamento atual
  momento          text not null,  -- está em lançamento ou não
  time_marketing   text not null,  -- próprio / terceirizado / ambos
  verba            text not null,  -- faixa de verba de marketing
  score            int  not null default 0,
  temperatura      text not null default 'frio', -- quente / morno / frio
  utm_source       text,
  utm_medium       text,
  utm_campaign     text,
  utm_content      text,
  referrer         text
);

alter table public.qualificacoes enable row level security;

-- O site público só pode INSERIR. Leitura apenas pelo painel do Supabase / service role.
drop policy if exists "quiz pode inserir" on public.qualificacoes;
create policy "quiz pode inserir"
  on public.qualificacoes for insert
  to anon
  with check (
    char_length(nome) between 2 and 120
    and char_length(email) between 5 and 160
    and char_length(telefone) between 10 and 20
    and char_length(incorporadora) between 2 and 160
  );

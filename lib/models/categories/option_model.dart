import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Option {
  String svg;
  String title;
   // List<Item> items;
  List<Map<String, dynamic>> items;
  Option({this.svg, this.title, this.items});
}

final options = [
  Option(
    svg: 'assets/mewnu/svgs/category_0.svg',
    title: 'Consumíveis',
    items: [
      {
        'title': 'Almoços e jantas',
        'value': 0.1,
      },
      {
        'title': 'Bebidas',
        'value': 0.2,
      },
      {
        'title': 'Bolos, Doces etc',
        'value': 0.3,
      },
      {
        'title': 'Cardápio / Menu',
        'value': 0.4,
      },
      {
        'title': 'Frios, embalados etc',
        'value': 0.5,
      },
      {
        'title': 'Lanches e Salgados',
        'value': 0.6,
      },
      {
        'title': 'Outros...',
        'value': 0.7,
      },
    ],
  ),
  Option(
    svg: 'assets/mewnu/svgs/category_1.svg',
    title: 'Imóveis',
    items: [
      {
        'title': 'Aluguel de quartos',
        'value': 1.1,
      },
      {
        'title': 'Apartamentos',
        'value': 1.2,
      },
      {
        'title': 'Casas',
        'value': 1.3,
      },
      {
        'title': 'Comércio e indústria',
        'value': 1.4,
      },
      {
        'title': 'Temporada',
        'value': 1.5,
      },
      {
        'title': 'Terrenos, sítios e Fazendas',
        'value': 1.6,
      },
      {
        'title': 'Outros...',
        'value': 1.7,
      },
    ],
  ),
  Option(
    svg: 'assets/mewnu/svgs/category_2.svg',
    title: 'Autos e peças',
    items: [
      {
        'title': 'Barcos e aeronaves',
        'value': 2.1,
      },
      {
        'title': 'Carros, vans e utilitários',
        'value': 2.2,
      },
      {
        'title': 'Caminhões',
        'value': 2.3,
      },
      {
        'title': 'Motos',
        'value': 2.4,
      },
      {
        'title': 'Ônibus',
        'value': 2.5,
      },
      {
        'title': 'Peças e acessórios',
        'value': 2.6,
      }, //lista
      {
        'title': 'Outros...',
        'value': 2.7,
      },
    ],
  ),
  Option(
      svg: 'assets/mewnu/svgs/category_3.svg',
      title: 'Para a sua casa',
      items: [
        {
          'title': 'Eletrodomésticos',
          'value': 3.1,
        },
        {
          'title': 'Materiais de construção e jardins',
          'value': 3.2,
        },
        {
          'title': 'Móveis',
          'value': 3.3,
        },
        {
          'title': 'Objetos de decoração',
          'value': 3.4,
        },
        {
          'title': 'Utilidades domésticas',
          'value': 3.5,
        },
        {
          'title': 'Outros...',
          'value': 3.6,
        },
      ]),
  Option(
      svg: 'assets/mewnu/svgs/category_4.svg',
      title: 'Eletrônicos e celulares',
      items: [
        {
          'title': 'Áudio, TV, vídeo e fotografia',
          'value': 4.1,
        },
        {
          'title': 'Celulares e telefonia',
          'value': 4.2,
        },
        {
          'title': 'Computadores e acessórios',
          'value': 4.3,
        },
        {
          'title': 'Videogames',
          'value': 4.4,
        },
        {
          'title': 'Outros...',
          'value': 4.5,
        },
      ]),
  Option(
      svg: 'assets/mewnu/svgs/category_5.svg',
      title: 'Música e hobbies',
      items: [
        {
          'title': 'Antiguidades',
          'value': 5.1,
        },
        {
          'title': 'CDs, DVDs etc',
          'value': 5.2,
        },
        {
          'title': 'Hobbies e coleções',
          'value': 5.3,
        },
        {
          'title': 'Instrumentos musicais',
          'value': 5.4,
        },
        {
          'title': 'Livros e revistas',
          'value': 5.5,
        },
        {
          'title': 'Outros...',
          'value': 5.6,
        },
      ]),
  Option(
      svg: 'assets/mewnu/svgs/category_6.svg',
      title: 'Esportes e Lazer',
      items: [
        {
          'title': 'Ciclismo',
          'value': 6.1,
        },
        {
          'title': 'Esportes e ginástica',
          'value': 6.2,
        },
        {
          'title': 'Outros...',
          'value': 6.3,
        },
      ]),
  Option(
      svg: 'assets/mewnu/svgs/category_7.svg',
      title: 'Artigos Infantis',
      items: [
        {
          'title': 'Brinquedos',
          'value': 7.1,
        },
        {
          'title': 'Roupas e vestimentas',
          'value': 7.2,
        },
        {
          'title': 'Outros...',
          'value': 7.3,
        },
      ]),
  Option(
      svg: 'assets/mewnu/svgs/category_8.svg',
      title: 'Animais de estimação',
      items: [
        {
          'title': 'Aquários e acessórios',
          'value': 8.1,
        },
        {
          'title': 'Cachorros e acessórios',
          'value': 8.2,
        },
        {
          'title': 'Cavalos e acessórios',
          'value': 8.3,
        },
        {
          'title': 'Gatos e acessórios',
          'value': 8.4,
        },
        {
          'title': 'Roedores e acessórios',
          'value': 8.5,
        },
        {
          'title': 'Outros animais e acessórios...',
          'value': 8.6,
        },
      ]),
  Option(
      svg: 'assets/mewnu/svgs/category_9.svg',
      title: 'Moda e beleza',
      items: [
        {
          'title': 'Beleza e Saúde',
          'value': 9.1,
        },
        {
          'title': 'Bolsas, malas e mochilas',
          'value': 9.2,
        },
        {
          'title': 'Bijouterias, relógios e acessórios',
          'value': 9.3,
        },
        {
          'title': 'Joias em geral',
          'value': 9.4,
        },
        {
          'title': 'Roupas',
          'value': 9.5,
        },
        {
          'title': 'Calçados',
          'value': 9.6,
        },
        {
          'title': 'Outros...',
          'value': 9.7,
        },
      ]),
  Option(
      svg: 'assets/mewnu/svgs/category_10.svg',
      title: 'Agro e indústria',
      items: [
        {
          'title': 'Animais para agropecuária',
          'value': 10.1,
        },
        {
          'title': 'Máquinas para produção industrial',
          'value': 10.2,
        },
        {
          'title': 'Máquinas pesadas para construção',
          'value': 10.3,
        },
        {
          'title': 'Peças para tratores e máquinas',
          'value': 10.4,
        },
        {
          'title': 'Produção Rural',
          'value': 10.5,
        },
        {
          'title': 'Tratores e máquinas agrícolas',
          'value': 10.6,
        },
        {
          'title': 'Outros itens para agro e indústria...',
          'value': 10.7,
        },
      ]),
  Option(
      svg: 'assets/mewnu/svgs/category_11.svg',
      title: 'Comércio e escritório',
      items: [
        {
          'title': 'Equipamentos e mobiliário',
          'value': 11.1,
        },
        {
          'title': 'Trailers e carrinhos comerciais',
          'value': 11.2,
        },
        {
          'title': 'Outros itens para comércio e escritório...',
          'value': 11.3,
        },
      ]),
  Option(svg: 'assets/mewnu/svgs/category_12.svg', title: 'Serviços', items: [
    {
      'title': 'Babá',
      'value': 12.1,
    },
    {
      'title': 'Ensaios fotográficos',
      'value': 12.2,
    },
    {
      'title': 'Eventos / Festas',
      'value': 12.3,
    },
    {
      'title': 'Informática / TI',
      'value': 12.4,
    },
    {
      'title': 'Profissionais liberais',
      'value': 12.5,
    },
    {
      'title': 'Reparação / Conserto / Reforma',
      'value': 12.6,
    },
    {
      'title': 'Saúde / Beleza',
      'value': 12.7,
    },
    {
      'title': 'Serviços domésticos',
      'value': 12.8,
    },
    {
      'title': 'Tradução',
      'value': 12.9,
    },
    {
      'title': 'Transporte / Mudanças',
      'value': 12.91,
    },
    {
      'title': 'Turismo',
      'value': 12.92,
    },
    {
      'title': 'Outros...',
      'value': 12.93,
    },
  ]),
  Option(
      svg: 'assets/mewnu/svgs/category_13.svg',
      title: 'Vagas de Emprego',
      items: [
        {
          'title': 'Administrativo / Secretariado / Finanças',
          'value': 13.1,
        },
        {
          'title': 'Agricultura / Pecuária / Veterinária',
          'value': 13.2,
        },
        {
          'title': 'Atendimento ao Cliente / Call Center',
          'value': 13.3,
        },
        {
          'title': 'Banco / Seguros / Consultoria / Jurídica',
          'value': 13.4,
        },
        {
          'title': 'Comercial / Vendas',
          'value': 13.5,
        },
        {
          'title': 'Construção / Industrial',
          'value': 13.6,
        },
        {
          'title': 'Educação / Formação',
          'value': 13.7,
        },
        {
          'title': 'Engenharia / Arquitetura / Design',
          'value': 13.8,
        },
        {
          'title': 'Logística / Distribuição',
          'value': 13.9,
        },
        {
          'title': 'Marketing / Comunicação',
          'value': 13.91,
        },
        {
          'title': 'Saúde / Medicina / Enfermagem',
          'value': 13.92,
        },
        {
          'title': 'Serviços Domésticos / Limpezas',
          'value': 13.93,
        },
        {
          'title': 'Telecomunicações / Informática / Multimídia',
          'value': 13.94,
        },
        {
          'title': 'Turismo / Hotelaria / Restaurante',
          'value': 13.95,
        },
        {
          'title': 'Outros...',
          'value': 13.96,
        },
      ]),
];

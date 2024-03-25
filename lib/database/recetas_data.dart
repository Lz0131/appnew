import 'package:appnew/database/model_recetas.dart';

const carruselImages = <Receta>[
  Receta(
    id: 1,
    name: "Pollo a la naranja",
    ingredients: ''' 1 1/2 Cucharadas de sal con ajo en polvo 
    \n 1 Cucharada de pimienta blanca 
    \n 1 Taza de fecula de maiz 
    \n 3 Tazas de harina de trigo 
    \n 2 Huevos 
    \n 1 Lata de Leche Evaporada CARNATION® CLAVEL® 
    \n 1.5 Kilogramos de pechuga de pollo cortada en cubos 
    \n Aceite de maiz para freir 
    \n 1 Cucharada de aceite vegetal 
    \n 1/2 Cucharada de jengibre fresco picado finamente 
    \n 1 Cucharada de ajo picado finamente 
    \n 1/2 Cucharada de hojuelas de chile 
    \n 1/2 Taza de azucar mascabado 
    \n 1/4 De taza de vinagre de arroz 
    \n 1 Taza de jugo de naranja 
    \n 1/4 Taza de Salsa de Soya MAGGI 
    \n 3 Cucharadas de fecula de maiz disuelta en 1/2 taza de agua 
    \n 1 Cucharada de aceite de ajonjoli 
    \n Ajonjoli blanco 
    \n Ajonjoli negro 
    \n 10 Ramas de cebollin desinfectado y picado finamente''',
    description: '''
        Para el pollo, mezcla la sal con ajo, la pimienta, 1 taza de fécula, la harina, los huevos y la Leche Evaporada CARNATION® CLAVEL®, bate perfectamente hasta integrar por completo. Añade el pollo y mezcla; refrigera por 1 hora. Fríe el pollo en el aceite caliente y coloca en papel absorbente para retirar el exceso de grasa.
        \nPara la salsa de naranja, calienta el aceite, fríe ligeramente el jengibre, el ajo y las hojuelas de chile. Añade el azúcar, el vinagre, el jugo de naranja y la Salsa de Soya MAGGI®; calienta hasta que hierva, agrega la fécula de maíz previamente disuelta y el aceite de ajonjolí; cocina hasta que espese ligeramente.''',
    image: "assets/carrusel/pollo_a_la_naranja.jpg",
  ),
  Receta(
    id: 2,
    name: "Sopa de Tomate",
    ingredients: ''' 1 kg de tomates maduros 
  \n 1 cebolla grande, picada 
  \n 2 dientes de ajo, picados 
  \n 2 cucharadas de aceite de oliva 
  \n 4 tazas de caldo de verduras 
  \n 1 cucharadita de azúcar 
  \n Sal y pimienta al gusto 
  \n 1/4 taza de albahaca fresca, picada 
  \n Crema fresca (opcional)''',
    description: '''
    En una olla grande, calienta el aceite de oliva a fuego medio. Agrega la cebolla y el ajo, y cocine hasta que estén suaves, aproximadamente 5 minutos.
    \nAgrega los tomates (previamente pelados y picados) a la olla junto con el caldo de verduras. Lleva la sopa a ebullición y luego reduce el fuego. Cocina a fuego lento durante unos 20-25 minutos.
    \nUsando una licuadora de mano o un procesador de alimentos, mezcla la sopa hasta que quede suave. Regresa la sopa a la olla y agrega la albahaca picada. Cocina a fuego lento durante otros 5 minutos.
    \nSazona con azúcar, sal y pimienta al gusto. Sirve caliente, con una cucharada de crema fresca si lo deseas.''',
    image: "assets/carrusel/sopa_de_tomate.jpg",
  ),
  Receta(
    id: 3,
    name: "Ensalada César",
    ingredients: ''' 2 pechugas de pollo, cocidas y cortadas en tiras 
  \n 1 lechuga romana, lavada y cortada en trozos 
  \n 1 taza de crutones 
  \n 1/2 taza de queso parmesano rallado 
  \n Para la salsa: 
  \n 1/2 taza de mayonesa 
  \n 2 cucharadas de jugo de limón 
  \n 2 dientes de ajo, picados 
  \n 1 cucharadita de mostaza Dijon 
  \n 2 filetes de anchoa en aceite, picados 
  \n Sal y pimienta al gusto''',
    description: '''
    En un tazón grande, mezcla la lechuga romana con los crutones y el queso parmesano.
    \nEn un tazón pequeño, mezcla la mayonesa, el jugo de limón, el ajo picado, la mostaza Dijon y las anchoas picadas hasta que estén bien combinados.
    \nAgrega la salsa a la ensalada y mezcla bien.
    \nColoca las tiras de pollo cocido encima de la ensalada y sirve.''',
    image: "assets/carrusel/ensalada_cesar.jpg",
  ),
  Receta(
    id: 4,
    name: "Pasta Alfredo con Pollo",
    ingredients: ''' 400g de pasta fettuccine 
  \n 2 pechugas de pollo, cortadas en trozos 
  \n 2 cucharadas de mantequilla 
  \n 2 dientes de ajo, picados 
  \n 1 taza de crema espesa 
  \n 1 taza de queso parmesano rallado 
  \n Sal y pimienta al gusto 
  \n Perejil fresco picado (opcional)''',
    description: '''
    Cocina la pasta de acuerdo con las instrucciones del paquete. Escurre y reserva.
    \nEn una sartén grande, derrite la mantequilla a fuego medio. Agrega el ajo picado y cocina hasta que esté fragante, aproximadamente 1 minuto.
    \nAgrega los trozos de pollo a la sartén y cocina hasta que estén dorados y cocidos por completo.
    \nReduce el fuego a medio-bajo y agrega la crema espesa y el queso parmesano rallado. Revuelve hasta que la salsa esté suave y el queso se haya derretido por completo. Sazona con sal y pimienta al gusto.
    \nAgrega la pasta cocida a la sartén y mezcla bien para cubrir la pasta con la salsa.
    \nSirve caliente, espolvoreado con perejil fresco picado si lo deseas.''',
    image: "assets/carrusel/pasta_alfredo_con_pollo.jpg",
  ),
  Receta(
    id: 5,
    name: "Hamburguesa de Pavo con Aguacate",
    ingredients: ''' 500g de carne molida de pavo 
  \n 1/4 taza de pan rallado 
  \n 1 huevo 
  \n 1 cucharadita de ajo en polvo 
  \n 1 cucharadita de cebolla en polvo 
  \n Sal y pimienta al gusto 
  \n 4 panes de hamburguesa 
  \n 1 aguacate, en rodajas 
  \n Lechuga, tomate y cebolla para decorar''',
    description: '''
    En un tazón grande, mezcla la carne molida de pavo con el pan rallado, el huevo, el ajo en polvo, la cebolla en polvo, la sal y la pimienta.
    \nForma la mezcla en cuatro hamburguesas.
    \nCocina las hamburguesas en una sartén grande o en una parrilla caliente durante unos 4-5 minutos por cada lado, o hasta que estén cocidas completamente.
    \nTuesta ligeramente los panes de hamburguesa.
    \nColoca las hamburguesas en los panes y decora con rodajas de aguacate, lechuga, tomate y cebolla.
    \nSirve caliente y disfruta.''',
    image: "assets/carrusel/hamburguesa_de_pavo_con_aguacate.jpg",
  ),
  Receta(
    id: 6,
    name: "Tacos de Camarones al Chipotle",
    ingredients: ''' 500g de camarones grandes, pelados y desvenados 
  \n 2 cucharadas de aceite de oliva 
  \n 2 dientes de ajo, picados 
  \n 1 lata de chiles chipotles en adobo 
  \n 1/2 taza de crema agria 
  \n 1 lima, el jugo 
  \n Sal y pimienta al gusto 
  \n Tortillas de maíz 
  \n Cilantro fresco picado 
  \n Cebolla morada en rodajas finas''',
    description: '''
    En una sartén grande, calienta el aceite de oliva a fuego medio. Agrega el ajo picado y cocina hasta que esté fragante, aproximadamente 1 minuto.
    \nAgrega los camarones a la sartén y cocina hasta que estén rosados y cocidos por completo.
    \nEn un tazón pequeño, mezcla los chiles chipotles en adobo (previamente picados), la crema agria y el jugo de lima. Sazona con sal y pimienta al gusto.
    \nCalienta las tortillas de maíz en una sartén caliente.
    \nColoca los camarones cocidos en las tortillas calientes y cubre con la salsa de chipotle, cilantro picado y cebolla morada en rodajas.
    \nSirve caliente y disfruta de estos deliciosos tacos.''',
    image: "assets/carrusel/tacos_de_camarones_al_chipotle.jpg",
  ),
  Receta(
    id: 7,
    name: "Risotto de Champiñones",
    ingredients: ''' 1 taza de arroz Arborio 
  \n 4 tazas de caldo de vegetales 
  \n 2 cucharadas de mantequilla 
  \n 1 cucharada de aceite de oliva 
  \n 1 cebolla pequeña, picada 
  \n 2 dientes de ajo, picados 
  \n 200g de champiñones, en rodajas 
  \n 1/2 taza de vino blanco 
  \n 1/2 taza de queso parmesano rallado 
  \n Sal y pimienta al gusto 
  \n Perejil fresco picado para decorar''',
    description: '''
    En una olla grande, calienta el caldo de vegetales a fuego medio-bajo y mantenlo caliente.
    \nEn otra olla grande, derrite la mantequilla junto con el aceite de oliva a fuego medio. Agrega la cebolla picada y el ajo picado, y cocina hasta que estén suaves, aproximadamente 5 minutos.
    \nAgrega los champiñones en rodajas a la olla y cocina hasta que estén dorados y hayan liberado sus jugos, aproximadamente 5 minutos más.
    \nAgrega el arroz Arborio a la olla y cocina, revolviendo constantemente, hasta que esté ligeramente dorado, aproximadamente 2 minutos.
    \nAgrega el vino blanco a la olla y cocina, revolviendo constantemente, hasta que se haya evaporado por completo.
    \nComienza a agregar el caldo caliente de vegetales, una taza a la vez, revolviendo constantemente y esperando a que el arroz absorba el líquido antes de agregar más.
    \nUna vez que el arroz esté cocido al dente y haya absorbido la mayoría del caldo, retira la olla del fuego y agrega el queso parmesano rallado. Mezcla bien.
    \nSazona con sal y pimienta al gusto. Sirve caliente, espolvoreado con perejil fresco picado.''',
    image: "assets/carrusel/risotto_de_champinones.jpg",
  ),
  Receta(
    id: 8,
    name: "Pescado al Horno con Vegetales",
    ingredients: ''' 4 filetes de pescado blanco (como la tilapia o el bacalao) 
  \n 2 zanahorias, cortadas en rodajas 
  \n 1 calabacín, cortado en rodajas 
  \n 1 pimiento rojo, cortado en tiras 
  \n 1 cebolla roja, cortada en rodajas 
  \n 2 cucharadas de aceite de oliva 
  \n 2 cucharadas de jugo de limón 
  \n 2 dientes de ajo, picados 
  \n Sal y pimienta al gusto 
  \n Perejil fresco picado para decorar''',
    description: '''
    Precalienta el horno a 200°C (400°F).
    \nEn una bandeja para hornear, coloca los filetes de pescado y los vegetales en una capa uniforme.
    \nEn un tazón pequeño, mezcla el aceite de oliva, el jugo de limón, el ajo picado, la sal y la pimienta.
    \nVierte la mezcla de aceite de oliva sobre el pescado y los vegetales, asegurándote de que estén bien cubiertos.
    \nHornea en el horno precalentado durante 20-25 minutos, o hasta que el pescado esté cocido y los vegetales estén tiernos.
    \nSirve caliente, espolvoreado con perejil fresco picado.''',
    image: "assets/carrusel/pescado_al_horno_con_vegetales.jpg",
  ),
  Receta(
    id: 9,
    name: "Arroz con Pollo",
    ingredients: ''' 1 taza de arroz 
  \n 2 pechugas de pollo, cortadas en trozos 
  \n 1 cebolla, picada 
  \n 2 dientes de ajo, picados 
  \n 1 zanahoria, cortada en cubos 
  \n 1 pimiento rojo, cortado en tiras 
  \n 1 lata de tomates pelados 
  \n 2 tazas de caldo de pollo 
  \n 1 cucharadita de comino molido 
  \n 1 cucharadita de pimentón 
  \n Sal y pimienta al gusto''',
    description: '''
    En una olla grande, calienta un poco de aceite a fuego medio. Agrega la cebolla, el ajo, la zanahoria y el pimiento rojo, y cocina hasta que estén suaves.
    \nAgrega el pollo a la olla y cocina hasta que esté dorado por todos lados.
    \nAgrega el arroz a la olla y cocina por un par de minutos, revolviendo constantemente.
    \nAgrega los tomates pelados, el caldo de pollo, el comino, el pimentón, la sal y la pimienta. Lleva la mezcla a ebullición, luego reduce el fuego y deja cocinar a fuego lento durante unos 20-25 minutos, o hasta que el arroz esté cocido y el líquido se haya absorbido.
    \nSirve caliente y disfruta.''',
    image: "assets/carrusel/arroz_con_pollo.jpg",
  ),
  Receta(
    id: 10,
    name: "Enchiladas Suizas",
    ingredients: ''' 12 tortillas de maíz 
  \n 2 pechugas de pollo, cocidas y desmenuzadas 
  \n 1 cebolla, picada 
  \n 2 dientes de ajo, picados 
  \n 1 lata de chiles verdes picados 
  \n 2 tazas de crema agria 
  \n 2 tazas de queso Monterey Jack rallado 
  \n 1/4 taza de cilantro fresco picado 
  \n 1/4 taza de jugo de limón 
  \n Sal y pimienta al gusto''',
    description: '''
    Precalienta el horno a 180°C (350°F).
    \nEn una sartén grande, saltea la cebolla y el ajo hasta que estén suaves. Agrega el pollo desmenuzado y los chiles verdes picados, y cocina por unos minutos más.
    \nEn un tazón grande, mezcla la crema agria, la mitad del queso rallado, el cilantro picado, el jugo de limón, la sal y la pimienta.
    \nCalienta las tortillas de maíz en un comal o sartén caliente durante unos segundos por cada lado para ablandarlas.
    \nRellena cada tortilla con una porción de la mezcla de pollo y enróllalas.
    \nColoca las enchiladas en una bandeja para hornear, cúbrelas con la mezcla de crema agria y espolvorea el queso rallado restante encima.
    \nHornea las enchiladas en el horno precalentado durante unos 20-25 minutos, o hasta que el queso esté burbujeante y dorado.
    \nSirve caliente y disfruta.''',
    image: "assets/carrusel/enchiladas_suizas.jpg",
  ),
];

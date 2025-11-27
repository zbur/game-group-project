List<List<String>> descriptionsAI = [
  ["Man kneeling on the floor, struggling to find hope",
  "Close-up of a distressed, suffering person",
  "Man in raggedy clothes covered in light he doesn't feel",
  "Man weeping beside ornate tomb, with a single rose adorning it",
  "Mother and baby crying at foot of podium",
  "Abstract semi-clothed figures despair admist jagged landscape"
  ],
  ["Medieval knight in armor fights dragon",
  "Goblins occupy a bridge",
  "Living shrub awakens in forest",
  "Portrait of ghoulish figures",
  "Witch attacks stylish 19th century centaur",
  "Flying horse lands near the Parthenon"
  ],
  ["Man looks longingly towards woman at ball",
  "Two women lean against each other in contemporary piece",
  "Grandma hugs her young grandson",
  "Stylish interwar couple embrace with onlooker in background",
  "Man and wife embrace in late 19th century prairie scene",
  "Couple gently argue, keeping some distance"
  ],
  ["Man on cliff looks in distance in surrealist piece",
  "Dark, moody autumn scene",
  "Bright open galaxy draws in surrounding, multicolored lights",
  "Antarctic penguins waddle in row, early 20th century",
  "Bright sun illuminates snowy, wooded landscape",
  "River flows through the valley of a vast, bright canyon"
  ],
  ["Bright heavenly light illuminates gorgeous green valleys of Greco-romanic civilisation",
  "Quaint early American church in the woods",
  "Iconography showcases christian religious figures speaking and praying for salvation",
  "Temple Mount in Jerusalem illuminated by bright light amidst misty haze",
  "Three wise men tend to baby Jesus in a manger",
  "Mary nurses baby Jesus in ancient church adorned with rich tapestries"
  ],
  ["Medieval army marches down hill to battle",
  "Proud knight stands solemnly outside castle by fancily dressed man dying from stab wound straight to his heart",
  "Ancient Hellenic armies fight at temple gates in heavily outnumbered match",
  "Cavalary man triumphs in the murky scenes of battle",
  "Soldier carries battered flag and rifle amidst the uncertainty of war",
  "Bearded 18th century soldiers row through their boat through rough waters"
  ]
];

List<List<String>> descriptionsReal = [
  ["The Despair Of Pierrot (1889) by James Ensor: Pierrot's Despair captures the melancholic commedia dell'arte figure surrounded by a grotesque carnival of masked faces. The composition is both theatrical and deeply personal, with the solitary white-clad Pierrot standing as a Christ-like figure amid mocking spectators.",
  "Despair (19th c.) by Bertha Wegmann:  This picture is reminiscent of the bohemian, marginalised existence encountered in Montmartre. In a domestic interior, a scene of high drama is enacted: the woman’s crumpled shirt articulates her torment.",
  "A Burial at Ornans (1850) by Gustave Courbet: The frieze-like portrayal of somber middle-class citizens at a graveside in Courbet's home province generates an explosive reaction among the painter's audience and critics. With few exceptions, viewers react to the work as an assault on the very idea of what a painting should be. To sophisticated Parisians, rural folk are considered proper fodder for small genre pieces; it's unprecedented to accord them the magisterial scope of the historical masterpieces of French tradition.",
  "Despair (2016) by Olivia Bell: The man in this painting is alone, underlining the profound loneliness of mental ill-health. The lack of colour explains the loss of passion, emotion and life. The hands clutch a faceless head, hoping to relieve the physical and mental symptoms, embodying the struggle as well as the helplessness. The facelessness aims to describe the loss of self both due to degradation of character and health.",
  "The Desperate Man (1843) by Gustave Courbet: With his eyes wide-open, Courbet is staring straight at you and tearing his hair. Popular at the time, the Romantic approach to portraiture was concerned with expressing emotional and psychological states of the individual.",
  "Lost in the Lights (2023) by Alexandra Kršňáková: A dark, enchanting work featuring a lady holding on tight to a bird amidst a faceless crowd who appear to be in a fog, as if non-existent, with subtle lights leaking through. It strongly depicts a feeling of deep loneliness and disconnect."
  ],
  ["Love and Saucers (2017) by David Huggins: An unassuming 74-year-old chronicles a life of alleged alien encounters through surreal impressionist paintings as a mode of self-therapy.",
  "Cadmus Slays the Dragon (17th c.) by Hendrick Goltzius: A painting of the legendary King of Thebes, Cadmus (from Greek mythology) slaying a dragon guarding the Spring of Ares. It depicts in stunning detail the dragon's violent but small and surreal nature.",
  "The Flying Monkeys Caught Dorothy in Their Arms (1900) by William Denslow: Two winged monkeys are carrying a young girl through the sky, while a third carries her dog and a fourth carries a manikin-like tin creature.",
  "When Pigs Can Fly (2014) by Jack Zulli: A surreal and whimsical digital-art painting of a pig flying through the sky, past wispy white clouds. Its composition is exceptionally unusual, with the patterned texture in particular throwing people off.",
  "Unicorn (1572) by Maerten de Vos: A medieval, real and battered appearing unicorn, with a proud stance. The colors, though faded, are bright and varied as if magic - like unicorns.",
  "Vampire (1894) by Edvard Munch: A man locked in a vampire's tortured embrace – her molten-red hair running along his soft bare skin."
  ],
  ["Springtime (1873) by Pierre-Auguste Cot: A reveling pair of children, drunken with first love ... this Arcadian idyll, peppered with French spice.",
  "The Jewish Bride (1667) by Rembrandt: It is clearly a couple, although who they are is not clear. The faces appear to be portraits, but the clothes are unusual for the time. Perhaps they were contemporaries of Rembrandt's who posed as characters from the Bible.",
  "Untitled (2021) by Viktoria Lapteva: Painting about the relationship between a man and a woman, a story about eternal love. The painting depicts a couple of lovers who walk embracing along the seashore.",
  "The Kiss (1859) by Francesco Hayez: It is one of the emblematic images of the Pinacoteca and perhaps the most widely reproduced Italian painting of the whole of the 19th century, created with the aim of symbolizing the love of the motherland and thirst for life on the part of the young nation that had emerged from the Second War of Independence and which now placed so many hopes in its new rulers.",
  "The Cradle (1872) by Berthe Morisot : The baby sleeps peacefully as Edma looks on, holding a pose which appears to be a combination of slight anxiety and tiredness, typical of a new mother. Most women were restricted in their roles in society and this led to much of their art being devoted to scenes such as these.",
  "Watering Flowers (2013) by Wang Xingwei: The symbolism of the watering can as the head of the man, and the flower pot as the head of the woman expresses this theme of nurture. In a relationship, one grows with the help of their counterpart."
  ],
  ["An Extensive Landscape with Ruins (1665-75) by Jacob van Ruisdael: A grey, turbulent sky dominates the scene, but our eye is also caught by a patch of light in the fields: the sun has broken through a crack in the clouds.",
  "Niagara Falls, from the American Side (1866) by Frederic Church: A gorgeous view of the rushing waters from Niagara Falls with its characteristic rising mist and many rainbows.",
  "Autumn effect at Argenteuil (1873) by Claude Monet: In Autumn Effect at Argenteuil, from 1873, his handling of light seamlessly blends the factory chimney on the horizon with the tree-lined, dappled river.",
  "Bigger Trees Near Warter (2007) by David Hockney: Its subject returns Hockney to his native Yorkshire with a view of a landscape near Warter, west of Bridlington, just before the arrival of spring when the trees are coming into leaf.",
  "The Grand Canyon of the Yellowstone (1872) by Thomas Moran: The work combines his naturalist's eye for detail with a strong sense of the divine.",
  "Into the Woods (2023) by Bradley Lusa: A lush, green forest with tall, slender trees surrounds a winding path that leads deeper into the woods. Bright sunlight filters through the dense foliage, creating a serene, inviting atmosphere."
  ],
  ["The Baptism of Christ (1437-45) by Piero della Francesca: Christ stands in a shallow, winding stream as John the Baptist pours a small bowl of water over his head. Three angels in colourful robes witness the event.",
  "Belshazzar's Feast (1636-8) by Rembrandt: The man in the gold cloak, enormous turban and tiny crown is Belshazzar, King of Babylon. In the middle of the party, a clap of thunder came as a warning. God’s hand appeared from a cloud and wrote in Hebrew script: 'You have been weighed in the balance and found wanting.'",
  "Immaculate Heart of Mary (2023) by Charles Chambers: A minimalist digital-art portrait of the Virgin Mary, depicted as pure and graceful through tone and attire.",
  "The Lord's Prayer (1886-94) by James Tissot: A scene of Jesus praying with his disciples atop a hill in the Holy Land.",
  "Madonna with The Child and Two Angels (1465) by Fra Filippo Lippi: This picture just shows the artist’s beloved Lucretia - apparently with the artist’s infant son. The young woman has her hands folded in prayer.",
  "Christ With Mocking Soldier (1880) by Carl Bloch: A Roman soldier mocks Christ, who is adorned by a bloody crown of thorns. Christ's expression remains unchanged and unphased."
  ],
  ["Death and the Soldier (1917) by Hans Larwin: The military points his rifle at the enemy, although the real enemy is by his side, smiling and hugging him with his cold and skeletal hand.",
  "The Cave of Despair (1772) by Benjamin West: A tired soldier, so evidently suffering from strenuous warfare, is spared just barely from death by a kind-faced woman.",
  "That Two-Thousand-Yard Stare (1944) by Tom Lea: A marine, traumatised by war, stares into the distance as battle rages on.",
  "The Siege of Gibraltar (1782) by George Carter: British officers watch as Spanish forces attempt to take the strategic city of Gibraltar, all while the American Revolutionary War rages on.",
  "Man/Ready, Vietnam (1990) by Paul Wiliams: A scene depicting the depth of blood, death, heat, destruction and turmoil of the Vietnam War.",
  "The Territorials at Pozières (1917) by William Wollen: Pure chaos and destruction - the depth of tragedy and meaningless loss in WW1, as depicted by a war artist."
  ]
];
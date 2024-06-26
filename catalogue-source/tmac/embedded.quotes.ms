.\" ------------------------------------------------------------------
.\"  This is a weak attempt at trying to make quotations embedded
.\"  in two column MS (gtroff only) macros.
.\"
.\"  It sort of works, the left side is pretty much right.  The
.\"  right side needs a way of telling it to finish this line at
.\"  this length but then start the next indented.  What I get now
.\"  is not quite correct.  Time to ask jjc.
.\"  
.\"  Also, this is sort of just barely working.  It can only handle
.\"  one quote per page, I haven't tried quotes on the next page, etc.
.\" ------------------------------------------------------------------
.de QuoteTopRight1
.	nr myll \\n[pg@colw]/2
.	ll \\n[myll]u
.	nr mypo \\n[pg@colw]/2
.	po +\\n[mypo]u
.	wh \\n[QuoteBottomMark]u+1v QuoteBottomRight1
..
.de QuoteBottomRight1
.	ll
.	po
..
.\" ------------------------------------------------------------------
.de QuoteBottomLeft
.	ll \\n[pg@colw]u
.	ch QuoteBottomLeft
.	wh \\n[QuoteTopMark]u+1v QuoteTopRight1
..
.\" ------------------------------------------------------------------
.de QuoteStart
.	if !\\n[pg@ncols]=2 \{\
.		@error Quotes only supported in 2 column mode
.	\}
.	if !\\n[pg*col-num]=0 \{\
.		@error Quotes may be placed only in column 1.
.	\}
.	mk QuoteTopMark
.	ev 1
.	fi
.	nr myll \\n[pg@colw]*2/3+\\n[pg*gutw]
.	ll \\n[myll]u
.	nr mypo \\n[pg@colw]*2/3
.	po +\\n[mypo]u
.	ps +2
.	vs +2
.	sp 2
.	ft 2
..
.\" ------------------------------------------------------------------
.de QuoteStop
.	br
.	nr QuoteBottomMark \\n[nl]
.	vs
.	ps
.	po
.	ll
.	ps
.	sp |\\n[QuoteTopMark]u
.	ev
.	nr myll \\n[pg@colw]/2
.	ll \\n[myll]u
.	wh \\n[QuoteBottomMark]u QuoteBottomLeft
..
.\" ------------------------------------------------------------------
.2C
.LP
10th 1st 2nd 3rd 4th 5th 6th 7th 8th 9th a AAA AAAS Aarhus Aaron AAU
ABA Ababa aback abacus abalone abandon abase abash abate abater abbas
abbe abbey abbot Abbott abbreviate abc abdicate abdomen abdominal
abduct Abe abed Abel Abelian Abelson Aberdeen Abernathy aberrant
aberrate abet abetted abetting abeyance abeyant abhorred abhorrent
abide Abidjan Abigail abject ablate ablaze able ablution Abner abnormal
Abo aboard abode abolish abolition abominable abominate aboriginal
aborigine aborning abort abound about above aboveboard aboveground
abovementioned abrade Abraham Abram Abramson abrasion abrasive abreact
abreast abridge abridgment abroad abrogate abrupt abscess abscissa
abscissae absence absent absentee absenteeism absentia absentminded
absinthe absolute absolution absolve absorb absorbent absorption
absorptive abstain abstention abstinent abstract abstracter abstractor
abstruse absurd abuilding abundant abusable abuse abusive abut abutted
abutting abysmal abyss Abyssinia AC academe academia academic
.QuoteStart
This is a quote about gtroff.  It's pretty nice but painful
at times.
.QuoteStop
academician academy Acadia acanthus Acapulco accede accelerate
accelerometer accent accentual accentuate accept acceptant acceptor
access accessible accession accessory accident accidental accipiter
acclaim acclamation acclimate accolade accommodate accompaniment
accompanist accompany accomplice accomplish accord accordant accordion
accost account accountant Accra accredit accreditate accreditation
accretion accrual accrue acculturate accumulate accuracy accurate
accusation accusative accusatory accuse accustom ace acerbic acerbity
acetate acetic acetone acetylene ache achieve Achilles aching
achromatic acid acidic acidulous Ackerman Ackley acknowledge
acknowledgeable ACM acme acolyte acorn acoustic acquaint acquaintance
acquiesce acquiescent acquire acquisition acquisitive acquit acquittal
acquitting acre acreage acrid acrimonious acrimony acrobacy acrobat
acrobatic acronym acropolis across acrylate acrylic ACS act Actaeon
actinic actinide actinium actinolite actinometer activate activation
activism Acton actor actress Acts actual actuarial actuate acuity
acumen acute acyclic ad Ada adage adagio Adair Adam adamant Adams
Adamson adapt adaptation adaptive add added addend addenda addendum
addict Addis Addison addition additional additive addle address
addressee Addressograph adduce Adelaide Adele Adelia Aden adenine
adenoma adenosine adept adequacy adequate adhere adherent adhesion
adhesive adiabatic adieu adipic Adirondack adjacent adject adjectival
adjective adjoin adjoint adjourn adjudge adjudicate adjunct adjust
adjutant Adkins Adler administer administrable administrate
administratrix admiral admiralty admiration admire admissible admission
admit admittance admitted admitting admix admixture admonish admonition
ado adobe adolescent Adolph Adolphus Adonis adopt adoption adoptive
adore adorn adposition adrenal adrenaline Adrian Adriatic Adrienne
adrift adroit adsorb adsorbate adsorption adsorptive adulate adult
adulterate adulterous adultery adulthood advance advantage advantageous
advent adventitious adventure adventurous adverb adverbial adversary
adverse advert advertise advice advisable advise advisee advisor
advisory advocacy advocate Aegean aegis Aeneas Aeneid aeolian Aeolus
aerate aerial Aerobacter aerobic aerodynamic aerogene aeronautic
aerosol aerospace Aeschylus aesthete aesthetic afar affable affair
affect affectate affectation affectionate afferent affiance affidavit
affiliate affine affinity affirm affirmation affirmative affix afflict
affluence affluent afford afforest 
afforestation affricate affront
Afghan Afghanistan aficionado afield afire aflame afloat afoot
aforementioned aforesaid aforethought afoul afraid afresh Africa afro
aft aftereffect afterglow afterimage afterlife aftermath afternoon
afterthought afterward afterword again against Agamemnon agate Agatha
agave age Agee agenda agent agglomerate agglutinate agglutinin
aggravate aggregate aggression aggressive aggressor aggrieve aghast
agile aging agitate agleam Agnes Agnew agnomen agnostic ago agone agony
agouti agrarian agree agreeable agreed agreeing agribusiness Agricola
agricultural agriculture agrimony ague Agway ah ahead ahem Ahmadabad

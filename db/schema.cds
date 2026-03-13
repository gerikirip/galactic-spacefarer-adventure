using { cuid } from '@sap/cds/common';

entity Spacefarers : cuid {
    name: String;
    userName: String;
    stardustCollection: Integer;
    wormholeNavigationSkill: Integer;
    originPlanet: String;
    spaceSuitColor : SpaceSuitColor;
    department : Association to Departments;
    position   : Association to Positions;
}

type SpaceSuitColor : String enum {
    Red; Blue; Green; Yellow; White; Black;
}

entity Departments : cuid {
    name : String;
}

entity Positions : cuid {
    name : String;
}
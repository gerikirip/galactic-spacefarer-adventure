using { Spacefarers as Spacefarers_, Departments as Departments_, Positions as Positions_ } from '../db/schema';

service SpacefarerService {
    @restrict: [
        { grant: '*', to: 'galactic-commander' },
        { grant: ['READ', 'UPDATE'], to: 'authenticated-user', where: 'userName = $user' }
    ]
    entity Spacefarers as projection on Spacefarers_ {
        *,
        @readonly department.name as departmentName, 
        @readonly position.name as positionName
    };
    @readonly entity Departments as projection on Departments_;
    @readonly entity Positions   as projection on Positions_;
}
annotate SpacefarerService.Spacefarers with @odata.draft.enabled;
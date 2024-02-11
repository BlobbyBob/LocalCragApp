import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {Crag} from '../../../models/crag';
import {MenuItem} from 'primeng/api';
import {CragsService} from '../../../services/crud/crags.service';
import {TranslocoService} from '@ngneat/transloco';
import {ActivatedRoute, Router} from '@angular/router';
import {select, Store} from '@ngrx/store';
import {Title} from '@angular/platform-browser';
import {forkJoin, of} from 'rxjs';
import {catchError, take} from 'rxjs/operators';
import {selectIsLoggedIn} from '../../../ngrx/selectors/auth.selectors';
import {environment} from '../../../../environments/environment';
import {marker} from '@ngneat/transloco-keys-manager/marker';
import {Sector} from '../../../models/sector';
import {SectorsService} from '../../../services/crud/sectors.service';

@Component({
  selector: 'lc-sector',
  templateUrl: './sector.component.html',
  styleUrls: ['./sector.component.scss'],
})
export class SectorComponent implements OnInit{

  public crag: Crag;
  public sector: Sector;
  public items: MenuItem[];
  public breadcrumbs: MenuItem[] | undefined;
  public breadcrumbHome: MenuItem | undefined;

  constructor(private cragsService: CragsService,
              private sectorsService: SectorsService,
              private translocoService: TranslocoService,
              private router: Router,
              private store: Store,
              private title: Title,
              private route: ActivatedRoute) {
  }

  ngOnInit() {
    const cragSlug = this.route.snapshot.paramMap.get('crag-slug');
    const sectorSlug = this.route.snapshot.paramMap.get('sector-slug');
    forkJoin([
      this.cragsService.getCrag(cragSlug).pipe(catchError(e => {
        if (e.status === 404) {
          this.router.navigate(['/not-found']);
        }
        return of(e);
      })),
      this.sectorsService.getSector(sectorSlug).pipe(catchError(e => {
        if (e.status === 404) {
          this.router.navigate(['/not-found']);
        }
        return of(e);
      })),
      this.store.pipe(select(selectIsLoggedIn), take(1)),
      this.translocoService.load(`${environment.language}`)
    ]).subscribe(([crag, sector, isLoggedIn]) => {
      this.crag = crag;
      this.sector = sector;
      this.title.setTitle(`${sector.name} / ${crag.name} - ${environment.instanceName}`)
      this.items = [
        {
          label: this.translocoService.translate(marker('sector.infos')),
          icon: 'pi pi-fw pi-info-circle',
          routerLink: `/topo/${this.crag.slug}/${this.sector.slug}`,
          routerLinkActiveOptions: {exact: true}
        },
        {
          label: this.translocoService.translate(marker('sector.areas')),
          icon: 'pi pi-fw pi-sitemap',
          routerLink: `/topo/${this.crag.slug}/${this.sector.slug}/areas`,
        },
        // {
        //   label: this.translocoService.translate(marker('sector.gallery')),
        //   icon: 'pi pi-fw pi-images',
        //   routerLink: `/topo/${this.crag.slug}/${this.sector.slug}/gallery`,
        // },
        // {
        //   label: this.translocoService.translate(marker('sector.ascents')),
        //   icon: 'pi pi-fw pi-users',
        //   routerLink: `/topo/${this.crag.slug}/${this.sector.slug}/ascents`,
        // },
        {
          label: this.translocoService.translate(marker('sector.edit')),
          icon: 'pi pi-fw pi-file-edit',
          routerLink: `/topo/${this.crag.slug}/${this.sector.slug}/edit`,
          visible: isLoggedIn,
        },
      ];
      this.breadcrumbs = [
        {
          label: crag.name,
          routerLink: `/topo/${crag.slug}/sectors`
        },
        {
          label: sector.name,
        },
      ];
      this.breadcrumbHome = { icon: 'pi pi-map', routerLink: '/topo'};
    })
  }

}

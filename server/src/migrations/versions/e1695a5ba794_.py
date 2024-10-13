"""empty message

Revision ID: e1695a5ba794
Revises: 30651a1bdf23
Create Date: 2024-05-20 12:57:51.566721

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = 'e1695a5ba794'
down_revision = '30651a1bdf23'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('instance_settings', schema=None) as batch_op:
        batch_op.add_column(sa.Column('matomo_tracker_url', sa.String(length=120), nullable=True))
        batch_op.add_column(sa.Column('matomo_site_id', sa.String(length=120), nullable=True))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('instance_settings', schema=None) as batch_op:
        batch_op.drop_column('matomo_site_id')
        batch_op.drop_column('matomo_tracker_url')

    # ### end Alembic commands ###

"""empty message

Revision ID: 5d2ddfe9e865
Revises: a318163f3e81
Create Date: 2024-02-16 17:57:13.492409

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '5d2ddfe9e865'
down_revision = 'a318163f3e81'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('areas', schema=None) as batch_op:
        batch_op.add_column(sa.Column('short_description', sa.Text(), nullable=True))

    with op.batch_alter_table('crags', schema=None) as batch_op:
        batch_op.add_column(sa.Column('lat', sa.Float(), nullable=True))
        batch_op.add_column(sa.Column('lng', sa.Float(), nullable=True))

    with op.batch_alter_table('posts', schema=None) as batch_op:
        batch_op.create_unique_constraint(None, ['id'])

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('posts', schema=None) as batch_op:
        batch_op.drop_constraint(None, type_='unique')

    with op.batch_alter_table('crags', schema=None) as batch_op:
        batch_op.drop_column('lng')
        batch_op.drop_column('lat')

    with op.batch_alter_table('areas', schema=None) as batch_op:
        batch_op.drop_column('short_description')

    # ### end Alembic commands ###
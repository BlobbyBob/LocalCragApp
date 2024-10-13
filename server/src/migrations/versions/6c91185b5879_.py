"""empty message

Revision ID: 6c91185b5879
Revises: 57a2a67b93a1
Create Date: 2024-01-24 13:19:29.473522

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '6c91185b5879'
down_revision = '57a2a67b93a1'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('lines', schema=None) as batch_op:
        batch_op.drop_column('linepath')

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('lines', schema=None) as batch_op:
        batch_op.add_column(
            sa.Column('linepath', postgresql.JSON(astext_type=sa.Text()), autoincrement=False, nullable=False))

    # ### end Alembic commands ###

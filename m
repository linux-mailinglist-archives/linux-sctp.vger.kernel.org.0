Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF576CF11
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Aug 2023 15:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjHBNos (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Aug 2023 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjHBNor (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Aug 2023 09:44:47 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631810B;
        Wed,  2 Aug 2023 06:44:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d3522283441so2592516276.0;
        Wed, 02 Aug 2023 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690983885; x=1691588685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6fDSJ7bVl9DJhnNbJNn9yYS6U2XnMIL4S+YB5SBQAk=;
        b=hDOx5C7VN0mq/HjTs9oW1B4yqomTKLOaqdZD6bHdepCmuTCB6L14J/XkUp3RIzIkg+
         q1HviFSXJsEcOgCFm9sEqbLR+w0PEV2KhQPpLTbETV8jm8SD9AVCSVuhSP6Kc3vizO3f
         IU+THNU4MVUI8aTYm4ieOZknBVn0naiCULw71TiB/CcJmf9DuGQfxP+m1FLNuU3VpmjE
         K+skhtLoCbpPc07fJsjFCFG5ni9UPOUcjUUyY6C7TeqNwrbO31tJyxQ3udfKTV3LlnLT
         mCYltnyJPxTdEHovcLda3eAbuWYqBJZPXzeqeKoo67A6GqVxR9Amk+S7xCe/ScqCGF1T
         AUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690983885; x=1691588685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6fDSJ7bVl9DJhnNbJNn9yYS6U2XnMIL4S+YB5SBQAk=;
        b=ePtASu9zZOT2vIevLoe5kWeTNeLd0eX+H+LqhGMrjfM4eedBUfdhhGjqC+zLpAYk3x
         O7LGQSHyP4F0IDpdRSnV+FNVhL8GJ4NDO1lXY5EtVp5ODYVnFPg19JLkzV8Sk2fGj2xd
         I4tXPzlm/sI5SZQWISRZ6/Sv/sj3K82uMRcU+jDqAx4ZgYTm2qjBAtCGNWxlySqrVaS3
         E4TV9fob0e3eEaJVSL0v884dQr5BJYjVEKu+LfVFXpc5XYbTqQ/sB76huV8uk6xHHWze
         8xlnW+vp2oFESmjWRfobqJOxHsYq0v60n/HsbV42tAib06DNs/gsyUMuTbb7p7Ig7q1j
         8pOQ==
X-Gm-Message-State: ABy/qLaqFWgFm6tpgI8+gqZFCs7jch2wM8nwaX1C6nV842FMMBG03unx
        2rd8qNwBuXZuDc4m/huQfamLKsExt6GCvLZs6fY=
X-Google-Smtp-Source: APBJJlFnonWM+2t9C2r/SQ7DUhWsetbyvDkyYgz7tolRX/91Vht7ivli9q3ipM5ixFqVNTWlT49SJavv8BsSZfi2kWE=
X-Received: by 2002:a25:ae12:0:b0:cb6:f035:391 with SMTP id
 a18-20020a25ae12000000b00cb6f0350391mr12644017ybj.24.1690983884735; Wed, 02
 Aug 2023 06:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230731141030.32772-1-yuehaibing@huawei.com>
In-Reply-To: <20230731141030.32772-1-yuehaibing@huawei.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 2 Aug 2023 09:44:17 -0400
Message-ID: <CADvbK_e0n7Y28T6M=tX7htqp4HNdAnT_9FRBux_m46sgPXv9uQ@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: Remove unused function declarations
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     marcelo.leitner@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jul 31, 2023 at 10:10=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com=
> wrote:
>
> These declarations are never implemented since beginning of git history.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/sctp/sm.h      | 3 ---
>  include/net/sctp/structs.h | 2 --
>  2 files changed, 5 deletions(-)
>
> diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
> index f37c7a558d6d..64c42bd56bb2 100644
> --- a/include/net/sctp/sm.h
> +++ b/include/net/sctp/sm.h
> @@ -156,7 +156,6 @@ sctp_state_fn_t sctp_sf_do_6_2_sack;
>  sctp_state_fn_t sctp_sf_autoclose_timer_expire;
>
>  /* Prototypes for utility support functions.  */
> -__u8 sctp_get_chunk_type(struct sctp_chunk *chunk);
>  const struct sctp_sm_table_entry *sctp_sm_lookup_event(
>                                         struct net *net,
>                                         enum sctp_event_type event_type,
> @@ -166,8 +165,6 @@ int sctp_chunk_iif(const struct sctp_chunk *);
>  struct sctp_association *sctp_make_temp_asoc(const struct sctp_endpoint =
*,
>                                              struct sctp_chunk *,
>                                              gfp_t gfp);
> -__u32 sctp_generate_verification_tag(void);
> -void sctp_populate_tie_tags(__u8 *cookie, __u32 curTag, __u32 hisTag);
>
>  /* Prototypes for chunk-building functions.  */
>  struct sctp_chunk *sctp_make_init(const struct sctp_association *asoc,
> diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
> index 5c72d1864dd6..5a24d6d8522a 100644
> --- a/include/net/sctp/structs.h
> +++ b/include/net/sctp/structs.h
> @@ -1122,8 +1122,6 @@ void sctp_outq_free(struct sctp_outq*);
>  void sctp_outq_tail(struct sctp_outq *, struct sctp_chunk *chunk, gfp_t)=
;
>  int sctp_outq_sack(struct sctp_outq *, struct sctp_chunk *);
>  int sctp_outq_is_empty(const struct sctp_outq *);
> -void sctp_outq_restart(struct sctp_outq *);
> -
>  void sctp_retransmit(struct sctp_outq *q, struct sctp_transport *transpo=
rt,
>                      enum sctp_retransmit_reason reason);
>  void sctp_retransmit_mark(struct sctp_outq *, struct sctp_transport *, _=
_u8);
> --
> 2.34.1
>
Acked-by: Xin Long <lucien.xin@gmail.com>

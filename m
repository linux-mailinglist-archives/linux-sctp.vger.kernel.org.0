Return-Path: <linux-sctp+bounces-607-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25AB287A8
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Aug 2025 23:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE271CC6298
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Aug 2025 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA4245031;
	Fri, 15 Aug 2025 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzGRMhKx"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245424CEE8;
	Fri, 15 Aug 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755292781; cv=none; b=ix1uyhqZYLYCTP6XF6N1F/YtPQQ+iH80o4uqsRtnDdFiUf0gFryPSETnrTGGni7Dm6xb4/jj+y/pFNUoW42Vx30INtjYJ3txKytsThvv50u1cROoxFEiCbpA4zMIlB8SWGP9sZZJ0fAFYsrRZ4jNrjuMgCpCNGDJCDkcxz/DU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755292781; c=relaxed/simple;
	bh=osbK+NidJ6fe9BioPokX7wWLeoCjqwmjjqkkfv/cr6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I05RJ6FbUtr4ncDVzww+8sKD+iyRAHdK7dAan75bmO8wncyJV1WFENAUQzZcnvFMt0m6YR/zNptOAR66xw9PggwXxnCnLZA45wCIKTvXlhch0CdhYwJwfg2msAbWNIpkiyiFUocxXxIJ2HZHjW/NDy7W69zE8jZd5ayXQDBJQVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzGRMhKx; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e56ff1c11eso11265775ab.0;
        Fri, 15 Aug 2025 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755292779; x=1755897579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny0iGd628JnEoEUo6u++DHd3GYH7/1jKqFMyZSSKKPc=;
        b=UzGRMhKxojv3b5q3Emv1MivXRBfAjVE++PN1qbwqFITL+ck4fjMG9BaKnhlpzE8LDH
         xd/G0NKXya+tcjaA3gAWEuC3SXv9h9mKqU6JYBZeurptyavyt0+jND2chlTCVaiVuqtH
         ZI/20D/uoOud6lc8XdNUoCBX5Me51+7xAIm+Np3TqbFPINHjDDErMvsajDq0JKroVluM
         svSWO9dIDvinyABc1pwn5hAjzEJv/NYbT5lBn/3jMm+i+h2msglxAzBO2WgsY9b+Y7kO
         SZR4zZXDqPk/LbsjNuRC+3vhbJ63vLF/RRi8PbTvqdwo0oqpmPerZSNK4MbBxsquPbDH
         aB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755292779; x=1755897579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny0iGd628JnEoEUo6u++DHd3GYH7/1jKqFMyZSSKKPc=;
        b=ptL6CfaXONXFk+8+GVvUcxvdCQz+AkhqFUFQdv41qk6w+60NRfpkCnqmZPW/ijXtez
         VX6c7r4Z9BELntFzndrpRsCbX5pG46Xab772TBkpXgFIrU64RZL1v9E889E56JpsN3Zu
         +Wi4RXuL0R2CR6V1gbtaqHNS/ySC1X8lUUoMqBfEGoeKb1LoOiuxrqRq7n0o2dEKlnVP
         Z5W1nfucR4bdRLUh3pAH31dml87meJK2cd0n65lHFyc/6W5ipc20aVNOjzHKphYHjbSp
         0mOYLNbmJGTwr7v6M2YMUpqyFcgKRS3G/oGre63lczhfOBBqjPevgn9sIR1QgvZtXwQw
         l6iA==
X-Forwarded-Encrypted: i=1; AJvYcCV9wOrUl+zNdb0dxPKZc2Jvc8ARNLyQx4Vr/AHIISCmjjIuSQYuebQqcjS3NdCOKyNNfGdzdWfA@vger.kernel.org, AJvYcCXiPayvtIDloT6LWbXdKD488dDUxfzO9gsQ2gQxtHlJKOl7dii5fMoenqY2CZp7stlv+El3EnMN51eO9+s=@vger.kernel.org, AJvYcCXlw6/Wm52q0zuQUaPsKZADfLAlthZFlkvAC8wgrvkgqOI86kgT4le/5c0Uffce+Db8MDZR204H6kYGDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKy2PJNE7zQq9C6MxaZanak8re5vQ6FiAP2bucm/lrxULwEBo
	siU7aCFXqIDUStzLAkvr/4MZF+mp/4o+ARTcUNVDU4IPq/q6d3xLvMWnJKF471kPFGdulSM7cbu
	zu/4vh2bqHGoSQN8m4YB/4rKIo7ckk20=
X-Gm-Gg: ASbGnctpt7lXCShTbr51k8nrdgLDddDa9CNjbRiyduxNjtHeRV5iKJpce3Y7DxNAOdY
	VQohIJp/WbTZBiOe2vOEyCJ8ULluk7dXflgm8GUpEntUZEGvr3JymkQOyl/Txvyfxg7BOcIE2Un
	ZmhJSzkJJy6P7og1Jh5e1rtoR1Bvrp0HWhB+u7YjizIPImP4CIy+QhAPRWAd4EaCEZ0UQ/qLY9f
	BHe0n4wxw==
X-Google-Smtp-Source: AGHT+IGruZJHHuJSkXvvI6zO6adNO8v8W9hQb7SEGVm12I3hK2yf7/Y5uG5kgOh+lP5pWJzAArxz4LjA22ows3yY7qQ=
X-Received: by 2002:a05:6e02:1d89:b0:3e5:7e24:3edc with SMTP id
 e9e14a558f8ab-3e58391e0e7mr11494335ab.20.1755292778797; Fri, 15 Aug 2025
 14:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813040121.90609-1-ebiggers@kernel.org> <20250813040121.90609-4-ebiggers@kernel.org>
 <20250815120910.1b65fbd6@kernel.org>
In-Reply-To: <20250815120910.1b65fbd6@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 15 Aug 2025 17:19:27 -0400
X-Gm-Features: Ac12FXyoMC7HdRcTuJ9sH2SzT9qwOkx9-bIalnhQ98MqcLgjuBG1ae3gG0w45Qg
Message-ID: <CADvbK_csEoZhA9vnGnYbfV90omFqZ6dX+V3eVmWP7qCOqWDAKw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] sctp: Convert cookie authentication to
 use HMAC-SHA256
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 3:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 12 Aug 2025 21:01:21 -0700 Eric Biggers wrote:
> > +     if (net->sctp.cookie_auth_enable)
> > +             tbl.data =3D (char *)"sha256";
> > +     else
> > +             tbl.data =3D (char *)"none";
> > +     tbl.maxlen =3D strlen(tbl.data);
> > +     return proc_dostring(&tbl, 0, buffer, lenp, ppos);
>
> I wonder if someone out there expects to read back what they wrote,
> but let us find out.
I feel it's a bit weird to have:

# sysctl net.sctp.cookie_hmac_alg=3D"md5"
net.sctp.cookie_hmac_alg =3D md5
# sysctl net.sctp.cookie_hmac_alg
net.sctp.cookie_hmac_alg =3D sha256

This patch deprecates md5 and sha1 use there.
So generally, for situations like this, should we also issue a
warning, or just fail it?

Paolo, what do you think?

>
> It'd be great to get an ack / review from SCTP maintainers, otherwise
> we'll apply by Monday..
Other than that, LGTM.
Sorry for the late reply, I was running some SCTP-auth related tests
against the patchset.

